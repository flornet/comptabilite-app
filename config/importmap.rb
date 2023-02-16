# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js", preload: true
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/esm/index.js"
pin "currency.js", to: "https://ga.jspm.io/npm:currency.js@2.0.4/dist/currency.min.js"
pin "chartkick", to: "https://ga.jspm.io/npm:chartkick@5.0.1/dist/chartkick.esm.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.2.1/dist/chart.js"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"
pin "fontawesome-free", to: "https://ga.jspm.io/npm:fontawesome-free@1.0.4/attribution.js"

pin "app_core", preload: true

pin_all_from "app/javascript/controllers", under: "controllers"
