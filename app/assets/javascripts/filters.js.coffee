class Template
  constructor: ->
    @flash = Handlebars.compile $('#success_message').html()
    @label = Handlebars.compile $('#append_label').html()

Filter = {
  load_cases : (elem) ->
    $('#filter_cases').load $(elem).attr('href')
    $('#filters li.active').removeClass("active")
    $(elem).closest("li").addClass("active")
}

Label = {
  add_label : (elem) ->
    $form = $(elem).closest "form"
    $.ajax {
      type: 'POST',
      url: $form.attr 'action'
      data: "_method=put&" + $form.serialize()
      success: ->
        Label.success elem
    }
        
  success : (elem) ->
    $template = new Template()
  
    $('#flash_message').html($template.flash {msg: "Label added successfully"})
    $(elem)
      .closest(".panel-body")
      .find(".case_labels")
      .append($template.label({label: $(elem).val()}))
      
    $('option:selected', elem).remove()
    $('.case_new_label').remove() if $(elem).has('option').length <= 1      
}

$ ->
  $('.filter_link').on 'click', (e)->
    e.preventDefault()
    Filter.load_cases @
    
  $('.case_label_select').on 'change', ->
    Label.add_label @