// Filename: common.js

define(['windmill', 'datepicker'], function(App) {

    'user strict';

    console.log("[common] load...");

    var app = App;

    // Date format
    Date.prototype.format = function(f) {
        if (!this.valueOf()) return " ";

        var weekName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        var d = this;

        return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
            switch ($1) {
                case "yyyy":
                    return d.getFullYear();
                case "yy":
                    return (d.getFullYear() % 1000).zf(2);
                case "MM":
                    return (d.getMonth() + 1).zf(2);
                case "dd":
                    return d.getDate().zf(2);
                case "E":
                    return weekName[d.getDay()];
                case "HH":
                    return d.getHours().zf(2);
                case "hh":
                    return ((h = d.getHours() % 12) ? h : 12).zf(2);
                case "mm":
                    return d.getMinutes().zf(2);
                case "ss":
                    return d.getSeconds().zf(2);
                case "a/p":
                    return d.getHours() < 12 ? "AM" : "PM";
                default:
                    return $1;
            }
        });
    };

    String.prototype.string = function(len) {
        var s = '',
            i = 0;
        while (i++ < len) {
            s += this;
        }
        return s;
    };

    String.prototype.zf = function(len) {
        return "0".string(len - this.length) + this;
    };

    Number.prototype.zf = function(len) {
        return this.toString().zf(len);
    };

    // 숫자 타입에서 쓸 수 있도록 format() 함수 추가
    Number.prototype.format = function() {
        if (this == 0) return 0;
        var reg = /(^[+-]?\d+)(\d{3})/;
        var n = (this + '');
        while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
        return n;
    };

    // 문자열 타입에서 쓸 수 있도록 format() 함수 추가
    String.prototype.format = function() {
        var num = parseFloat(this);
        if (isNaN(num)) return "0";
        return num.format();
    };

    // bootstrap datepicker
    var requestDate = {

        el: $('#request-date'),

        initialize: function(target) {
            console.log("[request.date] initialize(" + target + ")");
            var self = this;
            this.el.datepicker({
                format: "yyyyYear mmMonth ddDay",
                language: "kr",
                orientation: "top left",
                autoclose: 'true'
            }).on('changeDate', function(e) {
                app.vent.trigger('common:date:change', self.getSelectedDate());
            });

            this.getDuration(target);
        },

        setDuration: function(duration) {
            console.log("[request.date] setDuration()");
            this.el.datepicker('setStartDate', duration.get("startDate"));
            this.el.datepicker('setEndDate', duration.get("endDate"));
            
            var endDate = new Date(duration.get("endDate"));
            // endDate.setDate(endDate.getDate() - 1);
            this.el.datepicker('setDate', endDate);
        },

        getDuration: function(target) {

            var self = this;
            
            var durationUrl = '';
            if (target == 'access') {
            	durationUrl = '/windmill-admin-monitor/api/access/duration';
			} else if (target == 'acms') {
				durationUrl = '/windmill-admin-monitor/api/integration/duration?target=acms';
			} else if (target == 'upms') {
				durationUrl = '/windmill-admin-monitor/api/integration/duration?target=upms';
			}
            
            $.getJSON(durationUrl, function(data) {
                console.log("[request.date] getDuration() : " + JSON.stringify(data));
                self.duration = new Backbone.Model(data);
            }).success(function() {
                self.setDuration(self.duration);
                app.vent.trigger('common:date:change', self.getSelectedDate());
            });
        },

        getSelectedDate: function() {
            return this.el.datepicker('getDate').format('yyyy-MM-dd');
        }
    };

    return {
        requestDate: requestDate
    };

    /*
    $.gritter.add({
        title : '컨텐츠 관리',
        text : '10 건의 신규 컨텐츠가 입수되었습니다.',
        image : 'img/icons/32/download.png',
        sticky : false
    });
    
    $.gritter.add({
        title : '사용자 관리',
        text : '10 명의 신규 사용자가 추가되었습니다.',
        image : 'img/icons/32/user.png',
        sticky : false
    });
    */
});
