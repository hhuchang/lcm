/**
 * Created by changcan on 2018/8/17.
 */

//获取当前窗口的高度和宽度
var _PageHeight=document.documentElement.clientHeight,
    _PageWidth=document.documentElement.clientWidth;
//计算loading框距离顶部和左部的距离
var _LoadingTop=_PageHeight>61?(_PageHeight-61)/2:0,
    _LoadingLeft=_PageWidth>215?(_PageWidth-215)/2:0;
//在页面未加载完毕之前显示的loading html 格式
var _LoadingHTML='<div id="loadingDiv" style="position:absolute;left:0;width:100%;height:' + _PageHeight + 'px;top:0;background:#f3f8ff;opacity:1;filter:alpha(opacity=80);z-index:10000;"><div style="position: absolute; cursor1: wait; left: ' + _LoadingLeft + 'px; top:' + _LoadingTop + 'px; width: auto; height: 57px; line-height: 57px; padding-left: 50px; padding-right: 5px; background: #fff url(/images/loading.gif) no-repeat scroll 5px 10px; border: 2px solid #95B8E7; color: #696969; font-family:\'Microsoft YaHei\';">页面加载中，请等待...</div></div>';
//显示loading效果
document.write(_LoadingHTML);
/*document.onreonreadystatechange = completeLoading;
 function completeLoading() {
 if (document.readyState=="complete"){
 var loadingMask = document.getElementById('loadingDiv');

 loadingMask.parentNode.removeChild(loadingMask);
 }

 }*/
window.onload=function () {


    var loadingMask = document.getElementById('loadingDiv');

    loadingMask.parentNode.removeChild(loadingMask);

};