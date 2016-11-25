from pyspark import SparkContextfrom pyspark.sql import HiveContextsc = SparkContext(appName="HiveQuery")
hive_context = HiveContext(sc)scale=2
call_center = hive_context.table("tpcds_text_"+str(scale)+".call_center")
catalog_page = hive_context.table("tpcds_text_"+str(scale)+".catalog_page")
catalog_returns = hive_context.table("tpcds_text_"+str(scale)+".catalog_returns")
catalog_sales = hive_context.table("tpcds_text_"+str(scale)+".catalog_sales")
customer = hive_context.table("tpcds_text_"+str(scale)+".customer")
customer_address = hive_context.table("tpcds_text_"+str(scale)+".customer_address")
customer_demographics = hive_context.table("tpcds_text_"+str(scale)+".customer_demographics")
date_dim = hive_context.table("tpcds_text_"+str(scale)+".date_dim")
household_demographics = hive_context.table("tpcds_text_"+str(scale)+".household_demographics")
income_band = hive_context.table("tpcds_text_"+str(scale)+".income_band")
inventory = hive_context.table("tpcds_text_"+str(scale)+".inventory")
item = hive_context.table("tpcds_text_"+str(scale)+".item")
promotion = hive_context.table("tpcds_text_"+str(scale)+".promotion")
reason = hive_context.table("tpcds_text_"+str(scale)+".reason")
ship_mode = hive_context.table("tpcds_text_"+str(scale)+".ship_mode")
store = hive_context.table("tpcds_text_"+str(scale)+".store")
store_returns = hive_context.table("tpcds_text_"+str(scale)+".store_returns")
time_dim = hive_context.table("tpcds_text_"+str(scale)+".time_dim")
warehouse = hive_context.table("tpcds_text_"+str(scale)+".warehouse")
web_page = hive_context.table("tpcds_text_"+str(scale)+".web_page")
web_returns = hive_context.table("tpcds_text_"+str(scale)+".web_returns")
web_sales = hive_context.table("tpcds_text_"+str(scale)+".web_sales")
web_site = hive_context.table("tpcds_text_"+str(scale)+".web_site")
store_sales = hive_context.table("tpcds_text_"+str(scale)+".store_sales")
call_center.registerTempTable("call_center")
catalog_page.registerTempTable("catalog_page")
catalog_returns.registerTempTable("catalog_returns")
catalog_sales.registerTempTable("catalog_sales")
customer.registerTempTable("customer")
customer_address.registerTempTable("customer_address")
customer_demographics.registerTempTable("customer_demographics")
date_dim.registerTempTable("date_dim")
household_demographics.registerTempTable("household_demographics")
income_band.registerTempTable("income_band")
inventory.registerTempTable("inventory")
item.registerTempTable("item")
promotion.registerTempTable("promotion")
reason.registerTempTable("reason")
ship_mode.registerTempTable("ship_mode")
store.registerTempTable("store")
store_returns.registerTempTable("store_returns")
time_dim.registerTempTable("time_dim")
warehouse.registerTempTable("warehouse")
web_page.registerTempTable("web_page")
web_returns.registerTempTable("web_returns")
web_sales.registerTempTable("web_sales")
web_site.registerTempTable("web_site")
store_sales.registerTempTable("store_sales")