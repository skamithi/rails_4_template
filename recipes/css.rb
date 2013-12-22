def customize_application_css
  comment "# Remove application.css"
  remove_file "app/assets/stylesheets/application.css"

  comment "# copy default application.css.sass"
  copy_from_repo 'app/assets/stylesheets/application.css.sass'
end

def create_custom_css
end
