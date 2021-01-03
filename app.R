# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

options("golem.app.prod" = TRUE)

reticulate::virtualenv_create(
  envname = 'python3_env', python = "python3"
)

reticulate::virtualenv_install(
  envname = 'python3_env',
  packages = c('numpy', 'pandas', 'sklearn'),
  ignore_installed = TRUE
)

reticulate::use_virtualenv('python3_env', required = TRUE)

pkgload::load_all()

hamiltonHowlong::run_app()
