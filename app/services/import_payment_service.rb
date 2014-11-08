require 'csv'

class ImportPaymentService

  class << self

    def import(file)
      results = {
        successful: [],
        unsuccessful: []
      }

      # encoding is iso-latin in the example file
      # a better app would try to detect the encoding automatically
      data = CSV.read(file, encoding: 'ISO8859-1', col_sep:';')
      data.each do |row|
        order = matching_order(row)
        if order
          results[:successful] << row
          order.payment = create_payment(row)
        else
          results[:unsuccessful] << row
        end
      end

      results
    end

    private

    def matching_order(row)
      matching_order_for_column(row[4])
    end

    def matching_order_for_column(column)
      order_number = if column =~ /K(?:u|ü|ue)ndigung[^\d]*(\d+)/
                       $1
                     end

      if order_number
        Order.where(number: order_number.to_i).first
      end
    end

    def create_payment(row)
      Payment.create(
        transaction_date: Date.parse(row[0]),
        value_date: Date.parse(row[1]),
        reference: "#{row[2]} #{row[3]}\n#{row[4]}\n#{row[7]}",
        iban: row[5],
        bic: row[6],
        amount: parse_amount(row[14]),
        currency: row[15]
      )
    end

    def parse_amount(amount)
      BigDecimal.new(amount.gsub(/,/, '.'))
    end

  end

end
