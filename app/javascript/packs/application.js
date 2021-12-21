// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

import "stylesheets/application"

function docReady(fn) {
  // see if DOM is already available
  if(document.readyState !="loading") {
    fn();
  } else if (document.addEventListener) {
    document.addEventListener("DOMContentLoaded", fn);
  } else {
    document.attachEvent("onreadystatechange", function() {
      if(document.readyState =="complete") {
        fn();
      }
    })
  }
}

docReady(function() {
  let previewToggle = document.getElementById("comment-preview-toggle");
  if (previewToggle !== null) {
    previewToggle.addEventListener("click", (e) => {
      document.getElementById("comment-form").style.display = "none";
      document.getElementById("comment-form-toggle").classList.remove("active");
      document.getElementById("comment-preview-toggle").classList.add("active");

      let content = document.getElementsByClassName("previewable-body")[0].value;
      let csrf_token = document.getElementsByName("authenticity_token")[0].value;
      fetch("/comments/preview", {
          method: "POST",
          headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
          },
          body: JSON.stringify({ content: content, authenticity_token: csrf_token })
      }).then(response => response.json())
      .then(data => {
          document.getElementById("comment-preview").innerHTML = data.preview;
          document.getElementById("comment-preview").style.display = "block";
      });
    });
  }

  let commentFormToggle = document.getElementById("comment-form-toggle");
  if (commentFormToggle !== null) {
    document.getElementById("comment-form-toggle").addEventListener("click", (e) => {
      document.getElementById("comment-preview").style.display = "none";
      document.getElementById("comment-form").style.display = "block";
      document.getElementById("comment-form-toggle").classList.add("active");
      document.getElementById("comment-preview-toggle").classList.remove("active");
    });
  }

  let roleDropdown = document.getElementsByClassName("role-dropdown");
  for(var i = 0, len=roleDropdown.length; i < len; i=i+1|0) {
    roleDropdown[i].addEventListener("change", (event) => {
      event.target.parentElement.submit();
    });
  }
});