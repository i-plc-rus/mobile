# NotificationModule является самостоятельной библиотекой, которую можно
# подключить к проекту в виде локального SPM пакета и использовать
# в любом тестовом проекте
#
# import NotificationModule ->
# let notificationModuleAssembly: INotificationModuleAssemly ->
# notificationModuleAssembly.assemble()
#
# assembly создаст основную вью библиотеки

# Так же внутри есть демо приложение, в котором можно потестировать
# функционал библиотеки.
# NotificationModule -> NotificationModuleDemo -> NotificationModuleDemo.xcodeproj

# Библиотека использует реальное беслатное API Swagger Petstore, подогнанное для
# условий конкурса. Для тестов необходимо сетевое подключениеПо этой же причине,
# на экране есть только общие "Настройки уведомлений", для всего приложения, без 
# типов. Так как подогнать API под типы уже не выйдет, но по сути уровень вложенности
# просто увеличиться на один и при наличии API под это, библиотеку можно легко 
# перестроить для добавления типов, для который нужны уведомления.
# 
# В отсутствии продуктовых требований, все сетевые ошибки отображаются как "Что-то
# пошло не так"

# В модуле не используется сторонних библиотек

# DI и структура модуля сделаны таким образом, чтобы легко встроиться в DI основного
# приложения при подключении.

# Все сервисы реализованы с минимально необходимой функциональностью, так как в
# обычной ситуации они должны приходить из вне, с основного приложения.

# В пакете отсутствует локализация, но все строки специально выведены в отдельный
# enum, который при подключении к основе, так же легко встроится в ту систему
# локализации и кодогенерации которая используется в основе.

# Цвета и шрифты так же вынесены отдельно, что позволит легко подключить их
# к дизайн системе основного приложения

# Весь функционал модуля размещен на одном экране, что дает возможность
# исключить навигацию внутри модуля и позволяет без проблем встроить модуль
# в навигационную систему основного приложения. Если дописывать типы 
# (было выше), то типы выйдут на основной экран, а 3 переключателя с 
# уведомлениями уйдут в sheet