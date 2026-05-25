(jsx_attribute
  (property_identifier) @_attribute_name
  (#any-of? @_attribute_name "class" "className" "style" "css" "tw")
  [
    (string
      (string_fragment) @tailwind)
    (jsx_expression
      (template_string) @tailwind.inner)
  ])

(call_expression
  function: [
    (identifier) @_ident
    (member_expression
      object: (identifier) @_object.ident)
  ]
  (#match? @_ident "(clsx|classnames|cn|t[vw]|css|cva)")
  (#eq? @_object.ident "tw")
  arguments: [
    ((arguments
     (_)+) @tailwind.inner._args
     (#set! @tailwind.inner._args "sort" "skip"))
    (template_string) @tailwind.inner._str
  ])
