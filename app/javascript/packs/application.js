// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "stylesheets/application"

function docReady(fn) {
    // see if DOM is already available
    if (document.readyState === "complete" || document.readyState === "interactive") {
        // call on next available tick
        setTimeout(fn, 1);
    } else {
        document.addEventListener("DOMContentLoaded", fn);
    }
}

docReady(function() {
  let commentPanes = document.getElementsByClassName("comment-pane-content");
  document.getElementById("comment-preview-toggle").addEventListener("click", (e) => {
    document.getElementById("comment-form").style.display = "none";
    document.getElementById("comment-form-toggle").classList.remove("active");
    document.getElementById("comment-preview-toggle").classList.add("active");

    let content = document.getElementById("comment_body").value;
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

  document.getElementById("comment-form-toggle").addEventListener("click", (e) => {
    document.getElementById("comment-preview").style.display = "none";
    document.getElementById("comment-form").style.display = "block";
    document.getElementById("comment-form-toggle").classList.add("active");
    document.getElementById("comment-preview-toggle").classList.remove("active");
  });
});