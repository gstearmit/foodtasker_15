
# Python coding conventions

* Follow all points in PEP-8, some exceptions are described and noted as `PEP-8 Exception` below.

* Always use double quote `"` instead of single quote `'` for consistency. This rule can apply to Jinja filters or Django template in templates as well.

* Never use backward slash `\` to continue the code in the next line, instead use parentheses `()` to wrap the code, remember to indent the next line after opening the parentheses. Example:
```python
    # bad
    if something in some_long_list_name \
    and something_else in some_other_list_name \
    and other_condition is True:
        # do something

    # good
    if (
        something in some_long_list_name
        and something_else in some_other_list_name
        and other_condition is True
    ):
        # do something
```

* (PEP-8 Exception) It's encouraged to write the operator `and` `or` in the beginning of the line if there are many criteria in the same condition statement. Above example demonstrates this point too.

* Wrap the string in parentheses always when you have the chance, it's better for cutting the string and indentation at the same time. In the end parentheses are cheap to use. Example:
```python
    # meh
    my_var = do_function_x(do_function_y("this is a long string "
                                         "as one argument so I "
                                         "need to cut it"))

    # good
    my_var = do_function_x(
        do_function_y(
            "this is a long string as one argument so "
            "I can cut it anytime I want"
        )
    )

    # another good example
    my_var = do_function_x(
        do_function_y(
            (
                "this is a long string as one argument so "
                "I can cut it anytime I want"
            ),
            (
                "this is another long string as argument so "
                "I can cut it anytime I want"
            )
        )
    )
```

* Long relative import is discouraged to use, use absolute import at the right time is preferable. Example:
```python
    # bad, this is quite confusing about where it's come from
    from ....libs.utils import util_fucntion
    from ...someapp.models import MyModel

    # good, this is much more clearer
    from myapp.libs.utils import util_fucntion
    from myapp.apps.someapp.models import MyModel

    # NOTE: 1 level relative import is still good though, example:
    # this
    from .models import AwesomeModel
    # is a bit better than
    from myapp.apps.long_name_app.models import AwesomeModel
```

* Order of import / head of a module:
```python
    # 1. builtin import, always order `import ...` before `from ... import ...`
    import os
    import functools
    from datetime import datetime

    # 2. framework
    from flask import request, render_template, json
    from flask.ext.classy import FlaskView

    # 3. external packages
    from sqlalchemy import func
    from sqlalchemy.sql.expression import text

    # 4. absolute import in same application
    from myapp.apps.contacts.models import db, Contact
    from myapp.libs.delivery import Delivery

    # 5. relative import within current package
    from .models import MyModel

    """
    Full example for above
    NOTE: you can use 1 blank line to separate different type of import, I would say there are at least 3 main types:
        - framework & other dependancies
        - application
        - Python builtin
    """
    import os
    import functools
    from datetime import datetime

    import arrow
    from flask import request, render_template, json
    from flask.ext.classy import FlaskView
    from sqlalchemy import func
    from sqlalchemy.sql.expression import text

    from myapp.apps.contacts.models import db, Contact
    from myapp.libs. import Delivery

    from .models import MyModel
```

* Use python string format function to format strings:
```python
    # bad
    str = "There are " + car_count + " cars and " + motor_count + " motorbikes in our parking ground."
    
    # good
    str = "There are {} cars and {} motorbikes in our parking ground.".format(car_count, motor_count)
    # or
    str = "There are {c_count} cars and {m_count} motorbikes in our parking ground.".format(m_count=motor_count, c_count=car_count)
    # or
    str = f"There are {car_count} cars and {motor_count} in our parking ground."  # python 3.6+
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTQ1NzI0MDcxNiw3MzA5OTgxMTZdfQ==
-->
Python coding conventions
Displaying Python coding conventions.