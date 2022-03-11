cook_book = [
  ['салат',
      [
        ['картофель', 100, 'гр.'],
        ['морковь', 50, 'гр.'],
        ['огурцы', 50, 'гр.'],
        ['горошек', 30, 'гр.'],
        ['майонез', 70, 'мл.'],
      ]
  ],
  ['пицца',
      [
        ['сыр', 50, 'гр.'],
        ['томаты', 50, 'гр.'],
        ['тесто', 100, 'гр.'],
        ['бекон', 30, 'гр.'],
        ['колбаса', 30, 'гр.'],
        ['грибы', 20, 'гр.'],
      ],
  ],
  ['фруктовый десерт',
      [
        ['хурма', 60, 'гр.'],
        ['киви', 60, 'гр.'],
        ['творог', 60, 'гр.'],
        ['сахар', 10, 'гр.'],
        ['мед', 50, 'мл.'],
        ['вода', 1550, 'мл.'],
      ],
   ],
  ['блины',
       [
           ['мука', 60, 'гр.'],
           ['яйца', 2, 'шт.'],
           ['соль', 10, 'гр.'],
           ['сахар', 30, 'гр.'],
           ['Растительное масло', 50, 'мл.'],
           ['Молоко', 1550, 'мл.'],
       ]
  ]
]

person = 5
# input('Enter number of persons: ')


for dish, products in cook_book:
    print(f'{dish.capitalize()}:')
    for product, w, r in products:
        print(f'{product}, {int(w)*person}, {r}')
    print()

