$ ->
  $('#search-results-table').DataTable pageLength: 100

  $('#search-results-table tbody').on 'click', 'tr', ->
    redirection = $(this).attr('id')
    console.log "id " + redirection
    document.location.href = redirection
    return
