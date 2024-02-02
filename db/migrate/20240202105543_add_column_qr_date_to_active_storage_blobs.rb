class AddColumnQrDateToActiveStorageBlobs < ActiveRecord::Migration[7.1]
  def change
    add_column :active_storage_blobs, :qr_date, :string, default: ''
  end
end
