/**
 * Created by changcan on 2018/7/12.
 */
function loadApk(apk) {
    var filePath=apk.value;
    console.log(filePath);
    alert(filePath);
    var fileExtsion=filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
    if (!checkFileExtsion(fileExtsion)){
        alert("请选择apk文件");
        apk.value="";
        return;
    }




}



function checkFileExtsion(ext) {
    if (!ext.match(/.apk/i)){
        return false;
    }
    return true;
}