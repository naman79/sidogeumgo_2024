(function(global){
    function $(selector){
        if (!(this instanceof $)) {
            return new $(selector);
        }

        if (selector === window) {
            this.elements = [window];
        } else if (typeof selector === 'string') {
            this.elements = Array.from(document.querySelectorAll(selector));
        } else if (selector instanceof HTMLElement) {
            this.elements = [selector];
        } else {
            this.elements = [];
        }
    }

    $.prototype.on = function(event, callback){
        this.elements.forEach(element => element.addEventListener(event, callback));
        return this;
    };

    $.prototype.off = function(event, callback){
        this.elements.forEach(element => element.removeEventListener(event, callback));
        return this;
    };

    $.prototype.css = function(property, value){
        this.elements.forEach(element => element.style[property] = value);
        return this;
    };

    $.prototype.each = function(callback){
        this.elements.forEach((el, idx) => callback.call(el, idx, el));
        return this;
    };

    $.prototype.innerWidth = function(){
        return this.elements[0].innerWidth;
    };

    $.prototype.innerHeight = function(){
        return this.elements[0].innerHeight;
    };

    $.prototype.offset = function(){
        if(this.elements[0] instanceof HTMLElement){
            const rect = this.elements[0].getBoundingClientRect();
            return { top: rect.top + window.scrollY, left: rect.left + window.scrollX };
        }
        return null;
    };

    $.prototype.show = function(){
        this.elements.forEach(element => element.style.display = '');
        return this;
    };

    $.prototype.hide = function(){
        this.elements.forEach(element => element.style.display = 'none');
        return this;
    };

    $.prototype.toggle = function(){
        this.elements.forEach(element => {
            element.style.display = (element.style.display === 'none') ? '' : 'none';
        });
        return this;
    };

    $.prototype.height = function(value){
        if(value === undefined){
            return this.elements[0].clientHeight;
        } else {
            this.elements.forEach(element => element.style.height = value + 'px');
        }
        return this;
    };

    // Mock 기능 추가
    var mockValues = {};

    $.mock = function(key, action, value){
        if (action === 'set') {
            mockValues[key] = value;
        } else if (action === 'get') {
            return mockValues[key];
        }
    };

    $.getFrameId = function(){
        return $.mock('getFrameId', 'get');
    };

    // 전역 함수 관리
    var globalFunctions = {};

    global.requires = function(name){
        return globalFunctions[name];
    };

    global.registerGlobal = function(name, func){
        globalFunctions[name] = func;
    };

    global.$ = $;
})(window);

