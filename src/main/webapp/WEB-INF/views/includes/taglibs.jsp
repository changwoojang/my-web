<%-- JSTL Tag--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- Spring Tag --%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- Tiles Tag --%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<%-- Variables --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="css" value="${ctx}/css"/>
<c:set var="img" value="${ctx}/img"/>
<c:set var="js" value="${ctx}/js"/>
<c:set var="lib" value="${ctx}/js/lib"/>
