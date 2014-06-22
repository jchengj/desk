$ ->
  $('.filter_link').on 'click', (e)->
    e.preventDefault()
    $('#filter_cases').load $(@).attr('href')
    $('#filters li.active').removeClass("active")
    $(@).closest("li").addClass("active")
    
  $('.case_label_select').on 'change' ->
    $.ajax {
      type: 'POST',
      url: '/cases/ + id,
      data: "_method=delete",
      success: -> 
        window.wizard.remove(id)
    }