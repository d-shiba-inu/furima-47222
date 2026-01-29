## Users テーブル
| Column                 | Type   | Options                   |
| ---------------------- | ------ | ------------------------- |
| nickname               | string | null: false               |
| email                  | string | null: false, unique: true |
| encrypted_password     | string | null: false               |
| birth_date             | date   | null: false               |
| firstname_full_letters | string | null: false               |
| lastname_full_letters  | string | null: false               |
| firstname_kana         | string | null: false               |
| lastname_kana          | string | null: false               |

### Associations
- has_many : items
- has_many : orders
- has_many : comments

## Items テーブル
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| introduce              | string     | null: false                    |
| category_id            | integer    | null: false                    |
| condition_id           | integer    | null: false                    |
| shipping_fee_status_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |
| shipping_duration_id   | integer    | null: false                    |
| price                  | integer    | null: false                    |
| comment                | references | null: true, foreign_key: true  |

### Associations
- belongs_to : user
- has_one    : order
- has_many   : comment
- belongs_to_active_hash : category
- belongs_to_active_hash : condition
- belongs_to_active_hash : shipping_fee_status
- belongs_to_active_hash : prefecture
- belongs_to_active_hash : shipping_duration


## Comments テーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| item                | references | null: false, foreign_key: true |
| content             | text       | null: false                    |

### Associations
- belongs_to : user
- belongs_to : item
- has_one    : address

## Orders テーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| item                | references | null: false, foreign_key: true |

### Associations
- belongs_to : user
- belongs_to : item
- has_one    : address

## Addresses テーブル
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefecture     | string     | null: false                    |
| city           | string     | null: false                    |
| street_address | string     | null: false                    |
| building       | string     | null: false                    |
| phone_number   | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

### Associations
- belongs_to : order

