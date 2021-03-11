import bulmaCalendar from 'bulma-calendar';

class comptaApp {
  // This executes when the function is instantiated.
  constructor() {
    this.setupBulma();
    this.setupFacture();

  }

  setupBulma() {
    (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
      const $notification = $delete.parentNode;

      $delete.addEventListener('click', () => {
        $notification.parentNode.removeChild($notification);
      });
    });

    // Initialize all input of type date
    var calendars = bulmaCalendar.attach('[type="date"]');
  }

  setupFacture() {
    this.facture = {};
    this.facture.table_lignes_facture = document.getElementById('table_lignes_facture');
    this._bindFieldsButtons();
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
      if (e.target && e.target.className == 'remove_fields') {
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
      fieldParent.style.display = 'none'
    }
  }
}

window.addEventListener('turbolinks:load', function () {
 new comptaApp();
});
