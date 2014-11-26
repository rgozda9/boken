class Product < ActiveRecord::Base # rubocop:disable ClassLength
  has_many :orders
  has_many :lineItems
  belongs_to :category
  has_many :ratings
  mount_uploader :image, ImageUploader

  validates :name, :description, :price, :stock_quantity, :status, :image,
            :rating, :category_id, presence: true
  validates :genre, presence: true, allow_blank: true
  validates :sale_price, presence: true, if: :on_sale_true?
  validates :on_sale, presence: true, if: '!sale_price.nil?'
  validates :name, uniqueness: true
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0,
                                             only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :rating, numericality: { greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 5 }
  validates :status, format: { with: /new|old/, message: "only 'old' or 'new'" }

  def on_sale_true?
    on_sale == false ? false : true
  end

  filterrific(
    default_settings: { sorted_by: 'updated_at_desc' },
    filter_names: [
      :search_query,
      :sorted_by,
      :with_name,
      :with_status,
      :with_rating,
      :with_on_sale,
      :with_category_id,
      :with_category_name,
      :with_updated_at
    ]
  )

  scope :search_query, lambda { | query |
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map do |e|
      "%#{ e }%"
    end
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map do
        or_clauses = [
          'LOWER(products.name) LIKE ?',
          'categories.name LIKE ?'
        ].join(' OR ')
        "(#{ or_clauses })"
      end.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    ).joins(:category)
  }

  scope :sorted_by, lambda { | sort |
    direction = (sort =~ /desc$/) ? 'desc' : 'asc'
    case sort.to_s
    when /^updated_at_/
      order("products.updated_at #{ direction }")
    when /^name_/
      order("LOWER(products.name) #{ direction }")
    when /^category_name_/
      includes(:category).order("categories.name  #{ direction }")
    when /^rating_/
      order("products.rating #{ direction }")
    else
      fail(ArgumentError, "Invalid sort option: #{ sort.inspect }")
    end
  }

  scope :with_category_id, lambda { |category_ids|
    where(category_id: [*category_ids])
  }

  scope :with_category_name, lambda { |category_name|
    where(category: { name: category_name }).joins(:category)
  }

  scope :with_updated_at_gte, lambda { |ref_date|
    where('products.updated_at >= ?', ref_date)
  }

  scope :with_on_sale, lambda { |sale|
    return nil if 0 == sale
    where(on_sale: true)
  }

  scope :with_status, lambda { |status|
    product_status = (status =~ /new$/) ? 'new' : 'old'
    if status.to_s == 'new'

      where('products.status = ?', product_status)

    else

      where('products.status = ?', product_status)
    end
  }

  scope :with_rating, lambda { |rating|
    where('products.rating >= ?', rating)
  }

  delegate :name, to: :category, prefix: true

  def self.sale
    return true unless :with_on_sale.nil?
  end

  def self.status
    [
      %w(New status_new),
      %w(Old status_old)
    ]
  end

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Updated date (newest first)', 'updated_at_desc'],
      ['Category (a-z)', 'category_name_asc'],
      ['Rating (highest to lowest)', 'rating_desc']
    ]
  end
end
