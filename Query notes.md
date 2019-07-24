
# Model and Query notes

* Use `CountryField` for `country` fields:
```python
    from django.db import models
    from boxme_countries.fields import CountryField
    
    class Order(models.Model):
        country = CountryField()
        ...
```

* Use `UnixTimeStampField` for time fields:
```python
    from django.db import models
    from unixtimestampfield import UnixTimeStampField
    
    class Order(models.Model):
        approved_at = UnixTimeStampField(
            use_numeric=True, round_to=0, null=True, blank=True
        )
        ...
```

* Use `prefetch_related` and `select_related` to reduce number of queries:
```python
    # models.py
    from django.db import models
    
    class Market(models.Model):
        name = models.CharField(max_length=50)

    class Order(models.Model):
        code = models.CharField(max_length=50)
        market = models.ForeignKey(Market, on_delete=models.PROTECT)

    class OrderLine(models.Model):
        order = models.ForeignKey(Order, on_delete=models.PROTECT, related_name="lines")
        product = models.ForeignKey(Product, on_delete=models.PROTECT)
        quantity = models.IntegerField()
```
```python
    # views.py
    from boxme_core import generics
    
    from .models import Order
    
    class OrderList(generics.ListCreateAPIView):
        queryset = Order.objects.prefetch_related("lines__product").select_related("market")
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTI5NzM2OTAzNiw3MzA5OTgxMTZdfQ==
-->
Query notes
Đang hiển thị Query notes.