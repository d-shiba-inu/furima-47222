## Users テーブル
| Column                    | Type   | Options                        |
| ------------------------- | ------ | ------------------------------ |
| nickname                  | string | null: false                    |
| email                     | string | null: false, unique: true      |
| encrypted_password        | string | null: false                    |
| birth_date                | date   | null: false                    |
| firstname_full-letters    | string | null: false                    |
| lastname_full-letters     | string | null: false                    |
| firstname_kana            | string | null: false                    |
| lastname_kana             | string | null: false                    |

### Associations
- has_many : items
- has_many : orders
- has_many : comments
- has_one  : name

## Items テーブル
| Column              | Type   | Options                        |
| ------------------- | ------ | ------------------------------ |
| name                | string | null: false                    |
| introduce           | string | null: false                    |
| category            | string | null: false                    |
| condition           | string | null: false                    |
| shipping_fee_status | string | null: false                    |
| user_id             | integer| null: false, foreign_key: true |
| address_id          | integer| null: false, foreign_key: true |
| shipping_duration   | string | null: false                    |
| price               | integer| null: false                    |
| comment_id          | integer| null: true, foreign_key: true  |

### Associations
- belongs_to : user
- has_one    : address
- has_one    : oder
- has_many   : comment

## Comments テーブル
| Column              | Type    | Options                        |
| ------------------- | ------- | ------------------------------ |
| user_id             | integer | null: false, foreign_key: true |
| item_id             | integer | null: false, foreign_key: true |
| content             | text    | null: false                    |

### Associations
- belongs_to : users
- belongs_to : items
- has_one    : address

## Addresses テーブル
| Column         | Type    | Options                        |
| -------------- | ------- | ------------------------------ |
| postal_code    | string  | null: false                    |
| prefecture     | string  | null: false                    |
| city           | string  | null: false                    |
| street_address | string  | null: false                    |
| building       | string  | null: false                    |
| phone_number   | string  | null: false                    |
| order_id       | integer | null: false, foreign_key: true |

### Associations
- belongs_to : orders
- belongs_to : items