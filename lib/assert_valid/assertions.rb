module AssertValid
  module Assertions
    def assert_invalid(invalid_record, attribute_name = nil, error_kind = nil)
      assert_not(
        invalid_record.valid?,
        "No validation errors raised. Record: #{invalid_record.inspect}"
      )
      if attribute_name
        assert_includes(
          invalid_record.errors.attribute_names,
          attribute_name,
          "Expected record to have a(n) #{attribute_name} error.
   Errors: #{invalid_record.errors.details}
   Record: #{invalid_record.inspect}"
        )
        if error_kind
          assert(
            invalid_record.errors.details[attribute_name].any? do |err_detail|
              err_detail[:error] == error_kind
            end,
            "Expected #{attribute_name} errors to include a #{error_kind} error.
           #{attribute_name} errors were: #{invalid_record.errors.details}"
          )
        end
      end
    end

    def assert_valid(record)
      assert(
        record.save,
        "Record could not be saved. Record: #{record.inspect}
   Errors: #{record.errors.details}"
      )
    end
  end
end
