def require_custom_javascript
  comment "# Require JS for JQuery, rails-timeago, i18n-js, bootstrap"
  insert_into_file 'app/assets/javascripts/application.js',
                   after: %r(require jquery_ujs\n) do <<-JAVASCRIPT
//= require i18n
//= require i18n/translations
//= require wiselinks
JAVASCRIPT
  end
end

def remove_require_tree
  gsub_file('app/assets/javascripts/application.js', /.*require_tree.*/,'')
end
