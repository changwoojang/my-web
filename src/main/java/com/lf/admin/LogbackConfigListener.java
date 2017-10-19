package com.lf.admin;

import java.io.File;
import java.io.FileNotFoundException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.LoggerFactory;
import org.springframework.util.ResourceUtils;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.util.WebUtils;

import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.classic.joran.JoranConfigurator;
import ch.qos.logback.classic.util.ContextInitializer;
import ch.qos.logback.core.joran.spi.JoranException;
import ch.qos.logback.core.util.OptionHelper;
import ch.qos.logback.core.util.StatusPrinter;

/**
 * Logback의 자동 초기화 기능을 사용하지 않고 직접 설정파일의 위치를 web application의 Context Parameter로
 * 지정할 수 있는 기능을 제공한다. 이 때 context parameter의 이름은 logbackConfigLocation이며 그 값은 아래
 * 형식을 따른다.
 * <ol>
 * <li>classpath:path/to/logback.xml e.g.
 * classpath:com/windmill/search/logback.xml
 * <li>file:/path/to/logback.xml e.g. file:${user.home}/.windmill/logback.xml
 * <li>/path/to/logback.xml e.g. /WEB-INF/logback.xml
 * </ol>
 * 3번의 경우 web application을 기준으로한 상대경로로 해석된다. logbackConfigLocation의 값에는 ${} 형식으로
 * 환경변수를 사용할 수 있다.
 * 
 * 지정한 위치에 파일이 존재하지 않거나, -Dlogback.configurationFile로 Logback 설정 파일 위치를 재지정한
 * 경우에는 Logback의 초기화 기능을 그대로 사용한다.
 * 
 * @see <a href="http://jira.qos.ch/browse/LOGBACK-557">LOGBACK-557
 *      ServletContextListener to relocate logback config, implementation
 *      provided</a>
 * @see <a
 *      href="http://static.springsource.org/spring/docs/3.1.x/javadoc-api/org/springframework/web/util/Log4jConfigListener.html">Spring
 *      Log4jWebConfigurer</a>
 * 
 */
public class LogbackConfigListener implements ServletContextListener {

	public static final String CONFIG_LOCATION_PARAM = "logbackConfigLocation";

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();

		// OS 환경 변수 (logback.configurationFile)로 설정파일을 지정한 경우에는 따로 처리하지 않는다.
		String logbackConfigFile = OptionHelper.getSystemProperty(ContextInitializer.CONFIG_FILE_PROPERTY);
		if (logbackConfigFile != null) {
			sc.log("logback was initialized from [" + logbackConfigFile + "]");
			return;
		}

		String location = sc.getInitParameter(CONFIG_LOCATION_PARAM);
		if (location == null) {
			sc.log("logbackConfigLocation is not set. Use default automatic configuration.");
			return;
		}

		try {
			File file = resolveLocation(sc, location);
			sc.log("Initializing logback from [" + location + "]");
			configureLogback(file);
		} catch (FileNotFoundException ex) {
			sc.log("logbackConfigLocation is set. But " + location + " is not found or readable.");
		}
	}

	private File resolveLocation(ServletContext sc, String location) throws FileNotFoundException {
		location = SystemPropertyUtils.resolvePlaceholders(location);

		if (!ResourceUtils.isUrl(location)) {
			// 일반적인 path 형식이면 web application 기준의 상대 경로로 해석
			location = WebUtils.getRealPath(sc, location);
		}

		File file = ResourceUtils.getFile(location);
		if (!file.exists()) {
			throw new FileNotFoundException("logback config file [" + location + "] not found.");
		}

		return file;
	}

	private void configureLogback(File file) {
		// assume SLF4J is bound to logback in the current environment
		LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();

		try {
			JoranConfigurator jc = new JoranConfigurator();
			jc.setContext(lc);
			// Call context.reset() to clear any previous configuration, e.g.
			// default configuration.
			// For multi-step configuration, omit calling context.reset().
			lc.reset();

			jc.doConfigure(file.getAbsolutePath());
		} catch (JoranException je) {
			// StatusPrinter will handle this
		}
		StatusPrinter.printInCaseOfErrorsOrWarnings(lc);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// assume SLF4J is bound to logback in the current environment
		LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();
		lc.stop();
	}

}
