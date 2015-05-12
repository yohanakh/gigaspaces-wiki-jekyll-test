---
layout: nil
---

$(function () {

  $(".tabsection").each(function(index) {
    list = "";

    $(this).find(".tab-pane").each(function(index) {
      list_class = "";
      timestamp = parseInt(Date.now() * Math.random()) ;

      if(index === 0){
        list_class = "class='active'";
        $(this).prop("class", $(this).prop("class") + " active");
      }

      list += "<li " + list_class +"><a href='#" + timestamp + $(this).prop("id") +"'>" + $(this).prop("title") +"</a></li>";
      $(this).prop("id", timestamp + $(this).prop("id"));
    });
    $(this).find(".nav").html(list);
  });

  $('.tabsection ul.nav a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });

  summary_url = "";
  $('.col-md-9').children('h1').slice(1).each(function(index, item) {
    summary_url += '<li><a href="#'+item.id+'">'+item.innerHTML+'</a></li>';
  });

  $("#summarypanel").html(summary_url);

  /*
  if (!$.isEmptyObject(tocheaders)) {
    $.each(tocheaders, function(tocindex, tocvalue) {
      toc_url = "";
      $("#" + tocindex).children(tocvalue).each(function(index, item) {
        toc_url += '<li><a href="#'+item.id+'">'+item.innerHTML+'</a></li>';
      });

      $("#toczone-top" + tocindex +",#toczone-bot" + tocindex).html(toc_url);

    });
  }

  if (!$.isEmptyObject(tocheadersz)) {
    $.each(tocheadersz, function(tocindexz, tocvaluez) {
      toc_urlz = "";
      $(".col-md-9").children(tocvaluez).each(function(index, item) {
        toc_urlz += '<li><a href="#'+item.id+'">'+item.innerHTML+'</a></li>';
      });

      $("#toczone-top" + tocindexz +",#toczone-bot" + tocindexz).html(toc_urlz);

    });
  }
  */

  if ($("#childrentree").length !== 0) {
    var childrentreeid = $("a:contains('" + $("title").text() +"')");
    var childrens_li = childrentreeid.siblings("ul").children("li");
    $("#childrentree").append("<ul></ul>");
    childrentreeul = $("#childrentree").children("ul");
    childrens_li.each(function() {
      tmp = $(this).clone();
      childrentreeul.append(tmp);
    });
  }

  if ($("#gallery").length !== 0) {
    $("#gallery a").fancybox();
  }

  $("#sidebar_menu").treeview({
    persist: "location",
    animation: "slow",
    collapsed: "true"
  });
  $("#toc_menu").fadeIn('slow');

  // $("#navigation").treeview({
  //   persist: "location"
  // });


  $('#edit-on-github').click(function(e) { 
    var path = location.pathname;
    var repo = "https://github.com/gigaspaces/gigaspaces-wiki-jekyll";
    //handling directories 

    if (path.indexOf("/", path.length - 1) !== -1) path = path.slice(0,-1);
    if (path.indexOf(".html") == -1) path += "/index.html";
    markdownFile = path.replace(".html", ".markdown");
    if (path.indexOf("/sbp/") != -1) {
      repo = "https://github.com/gigaspaces/gigaspaces-sbp-jekyll";
      markdownFile = markdownFile.replace("/sbp/", "/")
    }
    location.href=repo + "/edit/master" + markdownFile + "#";
  });

  var githubPopupPresented = sessionStorage.getItem('githubPopupPresented');
  var githubPopupTitle = 'Help Us Improve!';
  var githubPopupText = 'Found a mistake in this page? Click here to edit it in Github and propose your change!';

  var mq = window.matchMedia( "(min-width: 1024px)" );
  if (mq.matches) {

    $("#edit-on-github").popover({
      placement: 'left',
      html: 'true',
      title : '<span class="text-info"><strong>'+githubPopupTitle+'</strong></span>' +
              '<button type="button" id="close" class="close" onclick="$(&quot;#edit-on-github&quot;).popover(&quot;hide&quot;);">&times;</button>',
      content : githubPopupText
    });

    function enablePopoverOnMouseover() {
      $('#edit-on-github').on('mouseover', 
        function () {
          $('#edit-on-github').popover('show');  
        }
      );
            
      $('#edit-on-github').on('mouseleave', 
        function () {
          $('#edit-on-github').popover('hide');  
        }
      );
    }

    if (githubPopupPresented == null) {
      setTimeout(function() {  
        $('#edit-on-github').popover('show');
        sessionStorage.setItem('githubPopupPresented', 'true');

        setTimeout(function() { 
          $('#edit-on-github').popover('hide');
          enablePopoverOnMouseover();
        }, 5000);
      }, 500);
    } else {
      enablePopoverOnMouseover();
    }
  }

});