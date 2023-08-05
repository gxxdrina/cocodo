// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
// script.js 追加
import "script.js"
// Swiper追記
import Swiper from 'swiper/swiper-bundle.js';
import 'swiper/swiper-bundle.css';

// Bootstrap導入時、下記追加
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()