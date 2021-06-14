module ErrorLogging
  def log_error(error_message, error = nil, **args)
    logger.error({ :message => error_message, :error => error }.merge(args))
    # TODO: rollbar here as well...
  end

  def with_support(message)
    # TODO: extract support email as constant (later deploy env var?)
    "#{message}. Please contact support at developer.ernest@gmail.com"
  end
end
