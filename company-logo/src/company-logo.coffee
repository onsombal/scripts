LOGO_URL = "PNG-LOGO-ADDRESS"
css = "
#content h2.brand { padding-top: 0; height: 35px; }
#content h2.brand > a { float: left; margin-right: 5px; }
.company-logo { max-width: 300px; max-height: 35px; }
"
$('<style>').html(css).appendTo('head')
$('#content').find('h2.brand span').html('<img src="' + LOGO_URL + '" class="company-logo">')