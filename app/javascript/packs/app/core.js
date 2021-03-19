import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"
import currency from "currency.js";

class comptaApp {
  // This executes when the function is instantiated.
  constructor() {
    this.setupBulma();
    this.setupFacture();
    this.setupSelecteursStatut();
  }

  setupBulma() {
    // Dropdowns
    (document.querySelectorAll('.dropdown:not(.special)') || []).forEach(($dropdown) => {
      $dropdown.addEventListener('click', (event) => {
        if (event.target.closest('.dropdown-trigger') != null || event.target.classList.contains('dropdown-item')) {
          $dropdown.classList.toggle('is-active');
        }
        event.stopPropagation();
        document.addEventListener('click', (event) => {
          $dropdown.classList.remove('is-active');
        }, { once: true });
      });
    });

    // Close button for notifications
    (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
      const $notification = $delete.parentNode;

      $delete.addEventListener('click', () => {
        $notification.parentNode.removeChild($notification);
      });
    });

    // Initialize all input of type date
    flatpickr(".flatpickr", {
      dateFormat: "d/m/Y",
      locale: French
    });

    // Initialize clickable rows
    (document.querySelectorAll('.clickable-row') || []).forEach(($row) => {
      $row.addEventListener('click', (event) => {
        // console.log(event.target.closest('.dropdown-trigger'));
        if (event.target.closest('.dropdown') == null) { // Don't follow link if a button or dropdown is clicked
          if (event.metaKey || event.ctrlKey || event.altKey) {
            // Open a new tab
            var a = window.document.createElement("a");
            a.target = '_blank';
            a.href = $row.dataset.href;

            // Dispatch fake click
            var e = window.document.createEvent("MouseEvents");
            e.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
            a.dispatchEvent(e);
          } else {
            // Open in current window
            if (typeof Turbolinks !== 'undefined') {
              Turbolinks.visit($row.dataset.href);
            } else {
              window.location.assign($row.dataset.href);
            }
          }
        }
      });
    });
  }

  setupFacture() {
    this.facture = {};
    this.humanReadableCurrencyOptions = {
                                          separator: ' ',
                                          decimal: ',',
                                          symbol: '€',
                                          pattern: '# !',
                                          negativePattern: "- # !"
                                        };
    this.machineReadableCurrencyOptions = {
                                          separator: '',
                                          decimal: ',',
                                          symbol: '€',
                                          pattern: '#',
                                          negativePattern: "-#"
                                        };
    this.facture.table_lignes_facture = document.getElementById('table_lignes_facture');
    if (this.facture.table_lignes_facture !== null) {
      this.facture.total_ht_dummy     = document.getElementById('facture_montant_ht_dummy');
      this.facture.total_ht           = document.getElementById('facture_montant_ht');
      this.facture.montant_tva_dummy  = document.getElementById('facture_montant_tva_dummy');
      this.facture.montant_tva        = document.getElementById('facture_montant_tva');
      this.facture.total_ttc_dummy    = document.getElementById('facture_montant_ttc_dummy');
      this.facture.total_ttc          = document.getElementById('facture_montant_ttc');
      this.facture.taux_tva           = document.getElementById('facture_taxe_id');
      this.facture.client             = {};
      this.facture.client.id          = document.getElementById('facture_client_attributes_id');
      this.facture.client.nom         = document.getElementById('facture_client_attributes_client');
      this.facture.client.adresse     = document.getElementById('facture_client_attributes_adresse');
      this.facture.client.code_postal = document.getElementById('facture_client_attributes_code_postal');
      this.facture.client.ville       = document.getElementById('facture_client_attributes_ville');
      this.facture.client.pays        = document.getElementById('facture_client_attributes_pays');
      this.facture.client.numero_tva_intracommunautaire = document.getElementById('facture_client_attributes_numero_tva_intracommunautaire');
      this.facture.client.email       = document.getElementById('facture_client_attributes_email');
      this.facture.client.telephone   = document.getElementById('facture_client_attributes_telephone');
      this.facture.client.seleteur    = this.facture.client.nom.closest('.dropdown');
      this.facture.client.liste       = this.facture.client.seleteur.querySelectorAll('.dropdown-content')[0];
      this.facture.client.indicateur  = document.getElementById('creating-client-indicator');
      this._bindFieldsButtons();
      this._setupAutoGrow();
      this._setupPriceFields();
      this._setupAutoCompleteClient();
    } else {
      this.facture.table_lignes_facture = document.getElementById('table_lignes_devis');
      if (this.facture.table_lignes_facture !== null) {

        this.facture.total_ht_dummy     = document.getElementById('devi_montant_ht_dummy');
        this.facture.total_ht           = document.getElementById('devi_montant_ht');
        this.facture.montant_tva_dummy  = document.getElementById('devi_montant_tva_dummy');
        this.facture.montant_tva        = document.getElementById('devi_montant_tva');
        this.facture.total_ttc_dummy    = document.getElementById('devi_montant_ttc_dummy');
        this.facture.total_ttc          = document.getElementById('devi_montant_ttc');
        this.facture.taux_tva           = document.getElementById('devi_taxe_id');
        this.facture.client             = {};
        this.facture.client.id          = document.getElementById('devi_client_attributes_id');
        this.facture.client.nom         = document.getElementById('devi_client_attributes_client');
        this.facture.client.adresse     = document.getElementById('devi_client_attributes_adresse');
        this.facture.client.code_postal = document.getElementById('devi_client_attributes_code_postal');
        this.facture.client.ville       = document.getElementById('devi_client_attributes_ville');
        this.facture.client.pays        = document.getElementById('devi_client_attributes_pays');
        this.facture.client.numero_tva_intracommunautaire = document.getElementById('devi_client_attributes_numero_tva_intracommunautaire');
        this.facture.client.email       = document.getElementById('devi_client_attributes_email');
        this.facture.client.telephone   = document.getElementById('devi_client_attributes_telephone');
        this.facture.client.seleteur    = this.facture.client.nom.closest('.dropdown');
        this.facture.client.liste       = this.facture.client.seleteur.querySelectorAll('.dropdown-content')[0];
        this.facture.client.indicateur  = document.getElementById('creating-client-indicator');
        this._bindFieldsButtons();
        this._setupAutoGrow();
        this._setupPriceFields();
        this._setupAutoCompleteClient();
      }
    }
  }
  setupSelecteursStatut() {
    var selecteur_statut = document.querySelectorAll('.selecteur-statut');
    if (selecteur_statut.length > 0) {
      selecteur_statut.forEach(selecteur => {
        var type = "facture";
        if (selecteur.classList.contains('devis')) {
          type = "devis";
        }
        var links   = selecteur.querySelectorAll('.dropdown-item');
        var button  = selecteur.querySelectorAll('.dropdown-trigger .button')[0];
        var nom     = button.querySelectorAll('.nom')[0];
        if (links.length > 0) {
          links.forEach(link => {
            link.addEventListener('click', e => {
              e.preventDefault();

              button.classList.add('is-loading');
              button.classList.add('is-white');
              button.classList.remove('is-' + nom.innerText.normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(" ","-").toLowerCase());

              const token = document.getElementsByName("csrf-token")[0].content;
              const headers = new Headers();
              headers.append('X-CSRF-Token', token);

              const formData = new FormData();
              if (type == "facture") {
                formData.append('[facture][facture_statut_id]', link.dataset.factureStatutId);
              } else {
                if (type == "devis") {
                  formData.append('[devi][devis_statut_id]', link.dataset.deviStatutId);
                }
              }

              fetch(link.href + '.json', {
                method: 'PUT',
                headers: headers,
                body: formData
              })
                .then(response => response.json())
                .then(data => {
                  button.classList.remove('is-loading');
                  button.classList.remove('is-white');
                  button.classList.add('is-' + link.innerText.normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(" ","-").toLowerCase());
                  nom.innerText = link.innerText;
                })
                .catch((error) => {
                  button.classList.remove('is-loading');
                  button.classList.remove('is-white');
                  button.classList.add('is-' + nom.innerText.normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(" ","-").toLowerCase());
                  console.error('Error:', error);
                });
            })
          })
        }
      })
    }
  }

  _setupAutoCompleteClient() {
    this.facture.client.nom.addEventListener('input',  event => {
      // console.log(this.facture.client.nom.value);
      fetch("/clients.json?query[nom]="+this.facture.client.nom.value)
        .then(response => response.json())
        .then(data => this._updateClientsSuggestedList(data));
    })

    this.facture.client.nom.addEventListener('input',  event => {
      this.facture.client.indicateur.classList.remove('is-hidden');
      this.facture.client.id.value = '';
    }, { once: true })
  }

  _updateClientsSuggestedList(data) {
    var that = this;
    this.facture.client.liste.innerHTML = "";
    if (data.length > 0) {
      data.forEach(client => {
        var link = document.createElement("a");
        var linkName = document.createTextNode(client.nom);
        link.className = "dropdown-item";
        link.appendChild(linkName);
        link.addEventListener('click', event => {
          that.facture.client.id.value          = client.id;
          that.facture.client.nom.value         = client.nom;
          that.facture.client.adresse.value     = client.adresse;
          that.facture.client.code_postal.value = client.code_postal;
          that.facture.client.ville.value       = client.ville;
          that.facture.client.pays.value        = client.pays;
          that.facture.client.numero_tva_intracommunautaire.value = client.numero_tva_intracommunautaire;
          that.facture.client.email.value       = client.email;
          that.facture.client.telephone.value   = client.telephone;
          that.facture.client.seleteur.value    = client.seleteur;
          that.facture.client.indicateur.classList.add('is-hidden');
          that.facture.client.seleteur.classList.remove('is-active');
          this.facture.client.nom.addEventListener('input',  event => {
            that.facture.client.indicateur.classList.remove('is-hidden');
            that.facture.client.id.value = '';
          }, { once: true })
        })
        this.facture.client.liste.appendChild(link);
      })
      this.facture.client.seleteur.classList.add('is-active');
    } else {
      this.facture.client.seleteur.classList.remove('is-active');
    }
  }

  _setupPriceFields() {
    // Tracking changes in Taxe rate
    this.facture.taux_tva.addEventListener("change", event => {
      this._updateTVA();
      this._updateTotalTTC();
    })

    // Use event delegation to ensure any fields added after the page loads are captured.
    document.addEventListener('keydown', event => {
      if (event.target && event.target.type === 'text' && event.target.classList.contains('price-input')) {
        // console.log(event.keyCode);
        var allowed_key_codes = [8, 9, 13, 16, 37, 39, 46, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 109, 110, 188, 189, 190];
        var allowed_shift_key_codes = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57];
        var allowed_meta_key_codes = [65, 86, 90];
        var allowed_crtl_key_codes = [65, 86, 90];
        if (allowed_key_codes.includes(event.keyCode)
            || (event.metaKey && allowed_meta_key_codes.includes(event.keyCode))
            || (event.shiftKey && allowed_shift_key_codes.includes(event.keyCode))
            || (event.ctrlKey && allowed_crtl_key_codes.includes(event.keyCode))) {
          if (event.keyCode === 110 || event.keyCode === 188 || event.keyCode === 190) { // . and ,
            event.preventDefault();
            if (!event.target.value.includes(',')) {
              if(document.selection) {
                  var range = document.selection.createRange();
                  range.text = ',';
              }else if(event.target.selectionStart || event.target.selectionStart == '0') {
                  var start = event.target.selectionStart;
                  var end = event.target.selectionEnd;
                  event.target.value = event.target.value.substring(0, start) + ',' + event.target.value.substring(end, event.target.value.length)
                  event.target.selectionStart = start + 1;
                  event.target.selectionEnd = start +1;
              } else {
                event.target.value = event.target.value + ',';
              }
            }
          }
        } else {
          event.preventDefault();
        }
      }
    })

    // Tracking changes in lines inputs
    document.addEventListener('input', event => {
      if (event.target && event.target.type === 'text' && event.target.classList.contains('price-input')) {
        var realInput = event.target.previousElementSibling;
        var values = event.target.value.split(',');
        if (values.length === 2 && values[1].length > 2) {
          event.target.value = event.target.value.slice(0, -1)
        }
        realInput.value = event.target.value.replace(',', '.');
        this._updateTotalHT();
        this._updateTVA();
        this._updateTotalTTC();
      }
    })

    // Updating dummy fields values on focusOut
    document.addEventListener('focusout', event => {
      if (event.target && event.target.type === 'text' && event.target.classList.contains('price-input')) {
        event.target.value = this._formatHumanCurrency(event.target.value);
      }
    })

    // Updating real fields values on focusIn
    document.addEventListener('focusin', event => {
      if (event.target && event.target.type === 'text' && event.target.classList.contains('price-input') && event.target.value !== '') {
        event.target.value = this._formatMachineCurrency(event.target.value)
      }
    })
  }

  _formatHumanCurrency(value) {
    var new_value = currency(value, this.humanReadableCurrencyOptions);
    if (isNaN(new_value.value)) {
      new_value.value = 0;
      new_value.intValue = 0;
    }
    return(new_value.format());
  }

  _formatMachineCurrency(value) {
    var new_value = currency(value, this.machineReadableCurrencyOptions);
    return(new_value.format());
  }

  _updateTotalHT() {
    var priceInputs = document.querySelectorAll('.nested-fields:not(.is-hidden) .price-input');
    var total_ht = currency(0);
    if (priceInputs.length > 0) {
      priceInputs.forEach(priceInput => {
        var montant_ht = currency(priceInput.value, this.humanReadableCurrencyOptions);
        total_ht = currency(total_ht.value).add(montant_ht.value);
      })
    }
    this.facture.total_ht_dummy.innerText = this._formatHumanCurrency(total_ht);
    this.facture.total_ht.value = total_ht.value;
  }

  _updateTVA() {
    var total_ht = currency(this.facture.total_ht.value);
    var option_selectionnee = this.facture.taux_tva.selectedIndex ;
    var taux_tva = this.facture.taux_tva.options[option_selectionnee].dataset.taux;
    var montant_tva = total_ht.multiply(taux_tva);
    this.facture.montant_tva_dummy.innerText = this._formatHumanCurrency(montant_tva);
    this.facture.montant_tva.value = montant_tva.value;
  }

  _updateTotalTTC() {
    var total_ht = currency(this.facture.total_ht.value);
    var montant_tva = currency(this.facture.montant_tva.value) ;
    var total_ttc = total_ht.add(montant_tva) ;

    this.facture.total_ttc_dummy.innerText = this._formatHumanCurrency(total_ttc);
    this.facture.total_ttc.value = total_ttc.value;
  }

  _setupAutoGrow() {
    // Use event delegation to ensure any fields added after the page loads are captured.
    document.addEventListener('input', e => {
      if (e.target && e.target.classList.contains('auto-grow')) {
        this._autoGrow(e.target)
      }
    })

    // Set for current textarea loaded with page
    var textareas = document.querySelectorAll('.auto-grow');
    if (textareas.length > 0) {
      textareas.forEach(textarea => {
        this._autoGrow(textarea)
      })
    }
  }

  _autoGrow(textarea) {
    let textareaWrapper = textarea.closest('.grow-wrap')
    textareaWrapper.dataset.replicatedValue = textarea.value
  }

  _bindFieldsButtons() {
    var links = document.querySelectorAll('.add_fields');
    if (links.length > 0) {
      // Loop over each link on the page. A page could have multiple nested forms.
      links.forEach(link => {
        link.addEventListener('click', e => {
          this._addFields(link, e)
        })
      })
    }
    // Use event delegation to ensure any fields added after the page loads are captured.
    document.addEventListener('click', e => {
      if (e.target && e.target.classList.contains('remove_fields')) {
        this._removeFields(e.target, e)
      }
    })
  }

  _addFields(link, e) {
    var target = this.facture.table_lignes_facture.getElementsByTagName('tbody')[0]
    // Stop the function from executing if a link or event were not passed into the function.
    if (!link || !e) return
    // Prevent the browser from following the URL.
    e.preventDefault()
    // Save a unique timestamp to ensure the key of the associated array is unique.
    let time = new Date().getTime()
    // Save the data id attribute into a variable. This corresponds to `new_object.object_id`.
    let linkId = link.dataset.id
    // Create a new regular expression needed to find any instance of the `new_object.object_id` used in the fields data attribute if there's a value in `linkId`.
    let regexp = linkId ? new RegExp(linkId, 'g') : null
    // Replace all instances of the `new_object.object_id` with `time`, and save markup into a variable if there's a value in `regexp`.
    let newFields = regexp ? link.dataset.fields.replace(regexp, time) : null
    // Add the new markup to the form if there are fields to add.
    //newFields ? link.insertAdjacentHTML('beforebegin', newFields) : null
    newFields ? target.insertAdjacentHTML('beforeend', newFields) : null
  }

  _removeFields(link, e) {
    // Stop the function from executing if a link or event were not passed into the function.
    if (!link || !e) return
    // Prevent the browser from following the URL.
    e.preventDefault()
    // Find the parent wrapper for the set of nested fields.
    let fieldParent = link.closest('.nested-fields')
    // If there is a parent wrapper, find the hidden delete field.
    let deleteField = fieldParent
      ? fieldParent.querySelector('input[type="hidden"]')
      : null
    // If there is a delete field, update the value to `1` and hide the corresponding nested fields.
    if (deleteField) {
      deleteField.value = 1
      fieldParent.classList.add('is-hidden')
      this._updateTotalHT()
      this._updateTVA()
      this._updateTotalTTC()
    }
  }
}

window.addEventListener('turbolinks:load', function () {
 new comptaApp();
});
