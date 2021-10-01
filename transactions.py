import random
import datetime as dt
import json




customers = {1:
                {"firstName":"Jerry", "lastName":"Maguire","email":"info@jerrymaguire.com"},
            2:
                {"firstName":"Jenny", "lastName":"Maguire","email":"info@jennymaguire.com"},
            3:
                {"firstName":"Steve", "lastName":"Jobs","email":"info@stevejobs.com"},
            4:
                {"firstName":"Ivanka", "lastName":"Trump","email":"info@ivankatrump.com"},
            5:
                {"firstName":"Denzel", "lastName":"Washington","email":"info@dwashington.com"},
            6:
                {"firstName":"Kate", "lastName":"Beckinsale","email":"info@katebeckinsale.com"},
            7:
                {"firstName":"Jim", "lastName":"Carrey","email":"info@jimcarrey.com"},
            8:
                {"firstName":"Jennifer", "lastName":"Lawrence","email":"info@jlaw.com"},
            9:
                {"firstName":"Cardi", "lastName":"B","email":"info@bardi.com"},
            10:
                {"firstName":"Dwayne", "lastName":"Johnson","email":"info@therock.com"},
            11:
                {"firstName":"Emma", "lastName":"Watson","email":"hermione@granger.com"},
            12:
                {"firstName":"Will", "lastName":"Ferrell","email":"info@willferal.com"},
            13:
                {"firstName":"Kim", "lastName":"Kardashian","email":"kim@dash.com"},
            14:
                {"firstName":"Tom", "lastName":"Hanks","email":"forest@gump.com"},
            15:
                {"firstName":"Britney", "lastName":"Spears","email":"trapped@freebritney.com"},
            16:
                {"firstName":"John", "lastName":"Krasinsky","email":"jim@theoffice.com"}
            }

items = {
    1:
        {"cost":50, "name":"glasses","dept":"accessories"},
    2:
        {"cost":60, "name":"pants","dept":"clothes"},
    3:
        {"cost":40, "name":"shirt","dept":"clothes"},
    4:
        {"cost":20, "name":"hat","dept":"accessories"},
    5:
        {"cost":80, "name":"shoes","dept":"footwear"},
    6:
        {"cost":20, "name":"belt","dept":"accessories"},
    7:
        {"cost":90, "name":"purse","dept":"accessories"},
    8:
        {"cost":30, "name":"tie","dept":"accessories"},
    9:
        {"cost":3000, "name":"ring","dept":"jewelry"},
    10:
        {"cost":1000, "name":"necklace","dept":"jewelry"},
    11:
        {"cost":800, "name":"bracelet","dept":"jewelry"},
    12:
        {"cost":500, "name":"earring","dept":"jewelry"},
    13:
        {"cost":3, "name":"pineapple","dept":"food"},
    14:
        {"cost":10, "name":"steak","dept":"food"},
    15:
        {"cost":6, "name":"pizza","dept":"food"},
    16:
        {"cost":3, "name":"eggs","dept":"food"},
    17:
        {"cost":1, "name":"bread","dept":"food"}        
}



counter = 1
trans_pre = dt.datetime.today().strftime('%y%m%d')
list_of_objects = []
while counter < 10:
    transactions = {}
    # create transaction id
    pad = '0'
    n = 3
    transaction_id = trans_pre + f'{counter:{pad}{n}}'
    # get random customer and item    
    rand_cust = random.choice(list(customers.items()))
    rand_item = random.choice(list(items.items()))
    # create random quantity and calculate the price
    rand_quant = random.randint(1,10)
    transactionCost = rand_quant * rand_item[1]["cost"]
    # customer details
    customerId = rand_cust[0]
    customerName = rand_cust[1]["firstName"]+" " +rand_cust[1]["lastName"]
    customerEmail = rand_cust[1]["email"]
    # item details
    itemId = rand_item[0]
    itemName = rand_item[1]["name"]
    itemCost = rand_item[1]["cost"]
    itemDept = rand_item[1]["dept"]
    # create transaction
    transactions[transaction_id] = {"customerName":customerName, "customerId":customerId, "customerEmail":customerEmail,"itemName":itemName, "itemId":itemId,"itemDept":itemDept,"itemCost":itemCost,"Quantity":rand_quant,"transactionCost":transactionCost}
    list_of_objects.append(transactions)
    counter +=1

with open('transactions','w') as f:
    for line in list_of_objects:
        f.write(json.dumps(line)+"\n")

f.write(json.dumps)
transactions[0]




trans={}
trans['transid'] = '12345'
trans['type'] = 'purchase'
trans['amount'] = 20
trans['custid'] = 'CID-1111'
filename = 'CID-1111.json'
uploadByteStream = bytes(json.dumps(trans).encode('UTF-8'))
uploadByteStream2 = bytes(json.dumps(list_of_objects).encode('UTF-8'))

