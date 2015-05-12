var postUrl = null;
var updatedTerm = false;
function start() {
    //  NProgress.start();
    $('#loading').attr('style', '');
    $("#loadingSpinner").show();
    $("#launch").hide();
    var iframe = $("#iframe");
    var postObj = {name: 'widget_play'};
    $.postMessage(JSON.stringify(postObj), postUrl, iframe.get(0).contentWindow);

    //for xap
    var $myDiv = $('#xapShell');
    if ($myDiv.length) {
        $('#xapShell').hide();
    }
}
function stop() {
    var iframe = $("#iframe");
    var postObj = {name: 'widget_stop'};
    $.postMessage(JSON.stringify(postObj), postUrl, iframe.get(0).contentWindow);
    // $.postMessage(JSON.stringify({name: 'widget_stopped'}), postUrl, iframe.get(0).contentWindow);
}

function isStateSuccess(state) {
    return (state.data && state.data.exitStatus && state.data.exitStatus.code === 0);
}

function updateButtonState(state) {

    if (state.name == 'widget_played' || state.name == 'widget_status') {
        $('#launch').data('launched', true).
            html("<span class='glyphicon glyphicon-stop'></span> Stop");
        $("#launch").show();
        $('#launch').css({"background": "#CD0004 ", "color": "white"});
        $(".pbarWrap").show();
        $('.panel').show(200);
        $("#loadingSpinner").hide();
//        $("#ytIframe").hide();
        if (isStateSuccess(state)) {
            $("#loading").hide();
        } else {
            $("#loading").show();
        }
//        $("#butterflyWrapper").show();
    } else if (state.name == 'widget_stopped') {
        //    NProgress.done();
        $('#launch').data('launched', false).
            html("<span class='glyphicon glyphicon-play'></span> Launch Now");
        $('#launch').css({"background": "#479c18 ", "color": "white"});
        $(".pbarWrap").hide();
        $('.panel').hide(200);
    }
}

function updateLog(logLines) {
    var $log = $("#log");
    $log.html(logLines.join('\n'));
    $log.scrollTop($log[0].scrollHeight);
}
function appendLog(line) {
    $('#log').append(('\n') + line);
}

function updateUseUrl(url, title) {
    var $use = $('#use');
    updateActionButton($use, url);
}
function updateYoutubeUrlBtn() {
    var tempurl = $("#ytIframe").attr("src");
    $("#watchVideoBtn").attr('href', tempurl);
}

function updateTermUrl(url) {
    if (!updatedTerm) {
        /* var html = '<iframe id="butterfly" src="' + url + '" width="768px" height="400px" frameborder="1" scrolling="auto"></iframe>';
         html = html + '<a class="hover-wrap fancybox fancybox.iframe" data-fancybox-group="gallery" title="Cloudify Your App on Chef" href="https://www.youtube.com/embed/JQUADOKF2kM" rel="gallery"><span class"btn btn-rounded btn-default"><i class="icon-play"></i> Watch</span></a>'
         html = html + '<h2>Type the following into the terminal window:</h2><ul><li>connect 127.0.0.1</li><li>list-applications</li><li>use-application chef-server</li><li>invoke chef-server listCookbooks</li><li>invoke chef-server updateCookbooks tar "http://s3.amazonaws.com/yoramw/apache.tgz" ""</li><li>invoke chef-server listCookbooks</li><li>install-service -overrides /tmp/customeatt.properties /tmp/base_chef</li><li>list-applications</li></ul>';
         $('#butterfly-iframe').html(html);*/
        updateYoutubeUrlBtn();
        $("#ytIframe").hide();
        $("#loading").hide();
        $("#butterfly").attr("src", url);
        $("#butterflyWrapper").show();
        updatedTerm = true;
    }
}

function updateManageUrl(url) {
    updateActionButton($('#manage'), url);
}
function updateTtyUrl(url) {
    var $tty = $('#tty');
    if ($tty) {
        updateActionButton($tty, url);
    }
}
function updateActionButton($elm, url) {
    $elm.attr('href', url);
    if (url) {
        $elm.removeClass('disabled');
        $elm.attr("disabled", false);
    } else {
        $elm.addClass('disabled');
        $elm.attr("disabled", true);
    }
}

function updateExpires(state) {
    if (state.data.nodeModel) {
        var expiresInMS = state.data.nodeModel.expires - new Date().getTime();
        updateTimeLeft(Math.floor(expiresInMS/1000/60));
    }
}

function updateTimeLeft(minutes) {
    $('#time-left').html(minutes);
}

function msToTime(duration) {
    var milliseconds = parseInt((duration % 1000) / 100)
        , seconds = parseInt((duration / 1000) % 60)
        , minutes = parseInt((duration / (1000 * 60)) % 60)
        , hours = parseInt((duration / (1000 * 60 * 60)) % 24);

    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;

    return hours + ":" + minutes + ":" + seconds + "." + milliseconds;
}

$(function () {
    //  var src = 'http://launch.cloudifysource.org/widget/widget?' +
    var src = ' http://thewidget.gsdev.info/#/widgets/547ed208ea1bc7600392caa5/blank?timestamp=141759'; //1417597979048
    // 'apiKey=' + WIDGET_ID +
    //  '&title=Launch' +
    //  '&origin_page_url=' + document.location.href;
    postUrl = src;
    var html = '<iframe id="iframe" src="' + src + '" width="600" height="463"></iframe>';
    $('#hidden-iframe').html(html);

    $('#launch').click(function () {
        if ($('#launch').data('launched')) {
            stop();
        } else {
            start();
        }
    });
    $('#use').click(function (e) {
        if ($('#use').hasClass('disabled'))
            e.preventDefault();
    });

    $.receiveMessage(function (e) {

        try {
            console.log(["parent got the message", e]);
            if (typeof(e.data) === 'string') {
                var msg = JSON.parse(e.data);
            } else {
                var msg = e.data;
                msToTime(e.timeStamp);
            }
            var $log = $("#log");

            if (msg.name == 'write_log') {
                $log.append($("<li/>", {html: msg.html}).addClass(msg.className));
                $log.scrollTop($log[0].scrollHeight);
            } else if (msg.name == "widget_loaded") {
                $("#launch").removeClass('disabled');
            } else if (msg.name == "widget_status") {
                // console.log(msg.status);
                // updateTimeLeft(msg.status.timeleft);
                updateButtonState(msg);
                updateExpires(msg);
                updateLog(msg.data.output);

                if (msg.data.nodeModel && !msg.data.nodeModel.publicIp) {
                    msg.data.nodeModel.publicIp = msg.data.nodeModel.machineSshDetails.publicIp;
                }

                if (msg.data.nodeModel && msg.data.nodeModel.publicIp) {
                    //Update manage  url
                    updateManageUrl('http://' + msg.data.nodeModel.publicIp + ':8099/');
                    if (msg.data.widget.consoleLink) {
                        if (msg.data.exitStatus && msg.data.exitStatus.code === 0) {
                            updateTermUrl('http://' + msg.data.nodeModel.publicIp + ':8080');
                        }
                        //Update use url
                        updateUseUrl(msg.data.widget.consoleLink.url.replace('$HOST', msg.data.nodeModel.publicIp), msg.data.widget.consoleLink.title);
                        updateTtyUrl('http://' + msg.data.nodeModel.publicIp + ':8080/');
                        // NProgres.done();
                    }
                }
                else {
                    updateTtyUrl();
                    updateUseUrl();
                }

//                updateLog(msg.data.output);
                if (msg.name != "widget_played") {
                    //$("#loading").attr('style', 'display:none');
                    //$("#butterflyWrapper").hide();
                    //$("#ytIframe").show();
                }
            } else if (msg.name == "widget_played") {
                updateButtonState(msg);
            } else if (msg.name == "widget_stopped") {
                updateButtonState(msg);
                appendLog('STOPPED');
                updateUseUrl();
                updateTtyUrl();
                updateManageUrl();

                // this section hide iframe and show youtube movie
                $("#loading").attr('style', 'display:none');
                $("#butterflyWrapper").hide();
                $("#butterfly").attr("src", "about:blank");
                $("#ytIframe").show();
                updateTimeLeft(19);
                updatedTerm = false;
            }

        } catch (exception) {
            console.log(["problem receiving message... ", e, exception]);
        }
    }, function (origin) {
        return true;
    });

    function calcTime() {
        //Chef Progress-bar
        var timeleft = e.timeStamp;
        var temptime = "";
        var $bar = $('.bar');
    }

    /*$('#time-left').bind("DOMNodeInserted ",function(timeleft){
     timeleft = $('#time-left').text()*60*1000;
     if (timeleft!=temptime){
     var lefttoshow = 100 - ((timeleft/1000/60)*100/19);
     var widthtoshow = 400 - ((timeleft * 400) / 1140000);
     $bar.width(widthtoshow.toFixed(0));
     $bar.text( lefttoshow.toFixed(0)+ "%");
     temptime = timeleft;
     }
     });

     $('#butterfly-iframe').bind("DOMNodeInserted ",function(timeleft){
     $('#loading').hide();
     });*/

    //on page load btn status
    if ($('#launch').text() == " Stop") {
        $('#launch').css({"background": "#CD0004 ", "color": "white "});
    } else {
        $('#launch').css({"background": "#479c18 ", "color": "white"});
        $(".pbarWrap").hide();
    }


});
