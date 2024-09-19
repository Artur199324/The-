# Устанавливаем глобальную минимальную версию iOS на 17.0
platform :ios, '17.0'

# Включаем использование модульных заголовков для повышения совместимости с некоторыми библиотеками
use_modular_headers!

target 'The legendary Couple' do
  use_frameworks!

  # Здесь можно добавить ваши зависимости, например:
  # pod 'AFNetworking', '~> 4.0'
  # pod 'Firebase/Analytics'

  target 'The legendary CoupleTests' do
    inherit! :search_paths
    # Здесь можно добавить зависимости для тестирования
  end

  target 'The legendary CoupleUITests' do
    inherit! :search_paths
    # Здесь можно добавить зависимости для UI-тестирования
  end
end

# Принудительно устанавливаем IPHONEOS_DEPLOYMENT_TARGET на 17.0 для всех конфигураций
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
    end
  end
end
