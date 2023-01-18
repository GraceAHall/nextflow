

params.message = 'Hello World'

process echo {
  input:
    message = params.message
  output:
    out = 'output.txt'
  script:
    'echo $message > output.txt'
}

process uppercase {
  input:
    message = echo.out
  script:
    """
    message_uppercase = message.toUpperCase()
    echo $message_uppercase > uppercase_message.txt
    """
}
