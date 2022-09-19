# flutter_mock_api_case_ersen_kocak



Flutter-Case Application.

## Genel Bilgilendirme
 - Uygulama Google Flutter Framework'ü kullanılarak geliştirilmiştir.
 - Emulator(IOS,Android), Gerçek Android Cihaz veGerçek Cihaz IOS olarak test edilmiştir



## Kullanılan Kütüphaneler


- [Bloc(State Management](https://pub.dev/packages/flutter_bloc)
- [Get It(Dependency Injection)](https://pub.dev/packages/get_it)
- [Logger](https://pub.dev/packages/logger)
- [Enviroment](https://pub.dev/packages/flavor)
- [Flutter EasyLoading](https://pub.dev/packages/flutter_easyloading)
- [Dio(Network Transactions)](https://pub.dev/packages/dio)
- [Pagination](https://pub.dev/packages/infinite_scroll_pagination)
- [Splash Screen](https://pub.dev/packages/flutter_native_splash)
- [Toast Messager](https://pub.dev/packages/fluttertoast)
- [Floating Action Bubble](https://pub.dev/packages/floating_action_bubble)
- [Datetime Format](https://pub.dev/packages/date_time_format)
- [Dialog](https://pub.dev/packages/ndialog)
- [Input Formatter](https://pub.dev/packages/mask_text_input_formatter)


## Servis Url
- [MOCK API](https://mockapi.io/)

https://6325f62170c3fa390f921965.mockapi.io/api/Person/

## Tasarım yaklaşımı

- Kullanılan Widget'ların parçalanması ve gerekli yerlerde tekrar kullanılmasını amaçlayan Atomic Design yaklaşımı referans alınmıştır.
Amaç; Kod Okunabilirliği, Widgeti'ların tekrar tekrar kullanılabilme opsiyonu ve dinamikleştirmek.Atomic Design için örnek döküman;
- [Atomic Design](https://itnext.io/atomic-design-with-flutter-11f6fcb62017)
- Kullanılan Widget'lar UI bazlı veya Uygulama geneli olma durumuna göre View dosyasının altında veya Core Katmanına eklendi

## Kullanılan Mimari

- Katmanlı mimari alt yapısı kullanılarak her katmanın kendi işini yapması amacıyla, kod okunabilirliği açısından ve sonra ki süreçte yapılan uygulamanın değişime direnç göstermemesi amacıyla BLoc Design Pattern kullanımıştır(Alternatif; Repository Pattern, MVVM)
- Katmanlar; 
  - Model(Model class'ların tutulduğu katmandır.Kullanılan dataların referans modelleri saklanır.)
  - View(UI elemanlarının tutulduğu katmandır ve sadece UI ile ilgili elemanlar tutulmalıdır)
  - Cubit(Business kodunun yazıldığı UI ve Service katmanı arasında ki iş akışını sağlayan katmandır.)
  - Service(Dış Servislere HTTP protokolü üzeriden bağlanılan katmandır.)
  - Core(Uygulama özelinde olmayan ve her hangi bir projede kullanılabilmesi amaçlanan uygulama geneli yapıları tutar,Uygulama bağımsızdır(Örn; Helpers, Constants ve Uygulama dışı kullanılabilecek uygulamaya bağımlı olmayan widgetların tutulduğu katmandır))

  İş akışı;
   View --> Cubit --> Services (Model ve Core katmanı ilgili iş akışına göre ilgili katmanda kullanılmaktadır.)
  ya da
   View <-- Cubit <-- Services (Model ve Core katmanı ilgili iş akışına göre ilgili katmanda kullanılmaktadır.)















