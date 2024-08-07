; extends

(call_expression
  function: [
    (await_expression
      (identifier) @_name
      (#eq? @_name "css"))
    ((identifier) @_name
      (#eq? @_name "css"))
  ]
  arguments: [
    (arguments
      (template_string) @injection.content)
    (template_string) @injection.content
  ]
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "css"))
