// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from 'jquery';
window.$ = $;

import 'popper.js';
import '../vendor/bootstrap';
import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';

window.Rails = Rails;
Rails.start();
Turbolinks.start();

import '@client-side-validations/client-side-validations'
import '@client-side-validations/simple-form/dist/simple-form.bootstrap4'
import '../src/new_voucher_form';
import '../src/smooth_scroll';
import '../src/analytics';

import Spinner from '../src/spinner';
window.spinner = new Spinner();

import PlaceForm from '../src/place_form';
window.PlaceForm = PlaceForm;

import VoucherPaymentForm from '../src/voucher_payment_form';
window.VoucherPaymentForm = VoucherPaymentForm;

import MobileShare from '../src/mobile_share';


import "../src/main_setup";
