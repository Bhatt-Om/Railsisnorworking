resources :event_enrolls do
  collection do
    get 'present/:qrcode_id', to: "event_enrolls#scanne_qr"
  end 
end