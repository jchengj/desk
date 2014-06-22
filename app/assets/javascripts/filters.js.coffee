$ ->
  flash_template = Handlebars.compile $('#success_message').html()
  label_template = Handlebars.compile $('#append_label').html()

  $('.filter_link').on 'click', (e)->
    e.preventDefault()
    $('#filter_cases').load $(@).attr('href')
    $('#filters li.active').removeClass("active")
    $(@).closest("li").addClass("active")
    
  $('.case_label_select').on 'change', ->
    $form = $(@).closest "form"
    $.ajax {
      type: 'POST',
      url: $form.attr('action')
      data: "_method=put&" + $form.serialize()
      success: -> 
        $('#flash_message').html(flash_template {msg: "Label added successfully"})
        $(@).closest(".case_labels").append(label_template({label: $(@).val()}))
    }