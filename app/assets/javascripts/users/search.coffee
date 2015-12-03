$ ->
  $('#search-results-table').DataTable()

  $('#search-results-table tbody').on 'click', 'tr', ->
    redirection = $(this).attr('id')
    console.log "id " + redirection
    document.location.href = redirection
    return
