def customize_application_view
  comment "replace default erb application view with custom haml view"
  copy_from_repo 'app/views/layouts/application.html.haml'
  remove_file 'app/views/layouts/application.html.erb'
end

def create_partials_for_layout

  comment "# Create basic header partial"
  copy_from_repo 'app/views/layouts/_header.html.haml'

  comment "# Create basic footer partial"
  copy_from_repo 'app/views/layouts/_footer.html.haml'
end
