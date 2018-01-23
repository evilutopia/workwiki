

ng-animate : Animation when model changes
-----------------------------------------
http://jsfiddle.net/AnandVishnu/c5p39/

<pre>

<div ng-app="myApp">
    <div ng-controller="AppCtrl">
      <input type="text" ng-model="test.value"></input>
      <span animate-on-change='test.value'>{{test.value | number}}</span>       
    </div>
</div>

[animate-on-change] {
  transition: all 1s;
  -webkit-transition: all 1s;
}
[animate-on-change].changed {
    background-color: red;
    transition: none;
    -webkit-transition: none;
}



angular.module('myApp', [])
    .controller('AppCtrl', function ($scope) {
     // todo   
  
}).directive('animateOnChange', function($timeout) {
    return function(scope, element, attr) {
        scope.$watch(attr.animateOnChange, function(nv,ov) {
            if (nv!=ov) {
                element.addClass('changed');
                $timeout(function() {
                    element.removeClass('changed');
                }, 1000);
            }
        });
    };  
});
</pre>
