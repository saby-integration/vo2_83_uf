
//////////////////////////////////////////////////////////////////////////////////

////////////////////// Управляемое приложение/////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
Функция ЗаполнитьСтруктуруФайла(СтрокаXML) Экспорт
	СтруктураФайла = Новый Структура;
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(СтрокаXML);
	ПостроительDOM = Новый ПостроительDOM; 
	Попытка
		ДокументДОМ = ПостроительDOM.Прочитать(ЧтениеXML);
		ПрочитатьУзелDOM(ДокументДОМ.ПервыйДочерний, СтруктураФайла);
	Исключение
	КонецПопытки;
	Возврат СтруктураФайла;
КонецФункции
Функция ПрочитатьУзелDOM(УзелDOM, Узел) 
	
	Уз = УзелDOM;
	Пока Уз<>Неопределено Цикл
		Если ТипЗнч(Уз) = Тип("ТекстDOM") Тогда
			//Узел.Вставить("Значение", Уз.ПолныйТекст);
			Если Узел.Количество() = 0 Тогда
				Узел = Уз.ПолныйТекст;
			Иначе
				Узел.Вставить("Параметр", Уз.ПолныйТекст);
			КонецЕсли;	
			Возврат Узел;
		Иначе	
			Если Уз.Атрибуты.Количество() <> 0 или Уз.ПервыйДочерний <> Неопределено Тогда
				НоваяСтруктура = Новый Структура;
				Атрибуты = Уз.Атрибуты;
				Для каждого Атрибут из Атрибуты Цикл
					Попытка
						НоваяСтруктура.Вставить(Атрибут.ИмяУзла, Атрибут.ЗначениеУзла);
					Исключение
					КонецПопытки;
				КонецЦикла;	
				Если Уз.ИмяУзла = "СтрТабл" Тогда
					Если Узел.Свойство("СтрТабл") = Ложь Тогда
						МассивСтрок = Новый Массив;
					Иначе
						МассивСтрок = Узел.СтрТабл;
					КонецЕсли;	
					МассивСтрок.Добавить(НоваяСтруктура);
					Узел.Вставить(Уз.ИмяУзла, МассивСтрок);
				ИначеЕсли Уз.ИмяУзла = "ДопАдрЭл" Тогда
					Если Узел.Свойство("ДопАдрЭл") = Ложь Тогда
						МассивСтрок = Новый Массив;
					Иначе
						МассивСтрок = Узел.ДопАдрЭл;
					КонецЕсли;	
					МассивСтрок.Добавить(НоваяСтруктура);
					Узел.Вставить(Уз.ИмяУзла, МассивСтрок);
				Иначе	
					Узел.Вставить(Уз.ИмяУзла, НоваяСтруктура);
				КонецЕсли;	
			КонецЕсли;	
		КонецЕсли;	
		Если Уз.ПервыйДочерний <> Неопределено Тогда
			Уз = УЗ.ПервыйДочерний;
			ДочУзел = Новый Структура;
			сбисСкопироватьСтруктуру(ДочУзел, Узел[УЗ.РодительскийУзел.ИмяУзла]);
			ПрочитатьУзелDOM(Уз, ДочУзел);
			Если УЗ.РодительскийУзел.ИмяУзла = "СтрТабл" Тогда
				сбисСкопироватьСтруктуру(Узел.СтрТабл[Узел.СтрТабл.Количество()-1], ДочУзел);
			ИначеЕсли УЗ.РодительскийУзел.ИмяУзла = "ДопАдрЭл" Тогда
				сбисСкопироватьСтруктуру(Узел.ДопАдрЭл[Узел.ДопАдрЭл.Количество()-1], ДочУзел);
			Иначе	
				Узел.Вставить(УЗ.РодительскийУзел.ИмяУзла, ДочУзел);
			КонецЕсли;	
			Уз = Уз.РодительскийУзел;
		КонецЕсли;
		Уз = Уз.СледующийСоседний;
	КонецЦикла;
	
	Возврат Узел;
	
КонецФункции		
Процедура сбисСкопироватьСтруктуру(СтруктураКуда, знач СтруктураОткуда)  Экспорт
	Для Каждого Элемент Из СтруктураОткуда Цикл	
		Если ТипЗнч(СтруктураОткуда) = Тип("Массив") Тогда
			
		ИначеЕсли ТипЗнч(Элемент.Значение) = Тип("Структура") Тогда
			//Если Не СтруктураКуда.Свойство(Элемент.Ключ) или СтруктураКуда[Элемент.Ключ] = Неопределено или ТипЗнч(СтруктураКуда[Элемент.Ключ])<>Тип("Структура") Тогда
			СтруктураКуда.Вставить(Элемент.Ключ, Новый Структура);
			//КонецЕсли;
			сбисСкопироватьСтруктуру(СтруктураКуда[Элемент.Ключ], Элемент.Значение);				
		ИначеЕсли Не СтруктураКуда.Свойство(Элемент.Ключ) Тогда
			СтруктураКуда.Вставить(Элемент.Ключ,Элемент.Значение);
		Иначе
			СтруктураКуда[Элемент.Ключ] = Элемент.Значение;			
		КонецЕсли;
	КонецЦикла;	
КонецПроцедуры
Процедура сбисЗаписатьИзменения(Стр, СтруктураАдреса)
	Контрагент = Стр.Контрагент.ПолучитьОбъект();
	
	Отбор = Новый Структура;
	Отбор.Вставить("Тип", Перечисления.ТипыКонтактнойИнформации.Адрес);
	Отбор.Вставить("Вид", Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента);
	АдресЗапись = Контрагент.КонтактнаяИнформация.НайтиСтроки(Отбор);
	Если АдресЗапись.Количество() = 0 Тогда
		АдресЗапись = Контрагент.КонтактнаяИнформация.Добавить();
		АдресЗапись.Тип = Перечисления.ТипыКонтактнойИнформации.Адрес;
		АдресЗапись.Вид = Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента;
	Иначе
		АдресЗапись = АдресЗапись[0];
	КонецЕсли;
	ЗначенияПолей = "";
	ЗначенияПолей = ЗначенияПолей+"Индекс="+СтруктураАдреса.Индекс+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"КодРегиона="+СтруктураАдреса.КодРегион+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"Район="+СтруктураАдреса.Район+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"Город="+СтруктураАдреса.Город+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"НаселенныйПункт="+СтруктураАдреса.НаселПункт+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"Улица="+СтруктураАдреса.Улица+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"Дом="+СтруктураАдреса.Дом+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"Корпус="+СтруктураАдреса.Корпус+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"Квартира="+СтруктураАдреса.Квартира+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"ТипДома="+СтруктураАдреса.ТипДома+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"ТипКорпуса="+СтруктураАдреса.ТипКорпуса+Символы.ПС;
	ЗначенияПолей = ЗначенияПолей+"ТипКвартиры="+СтруктураАдреса.ТипКвартиры;
	
	АдресЗапись.ЗначенияПолей = ЗначенияПолей;
	АдресЗапись.Представление = СбиСПолучитьПредставлениеАдрес(СтруктураАдреса);
	Контрагент.Записать();
КонецПроцедуры
Процедура сбисЗаполнитьСтруктуруАдреса(Контрагент, СтруктураАдреса)
	Отбор = Новый Структура;
	Отбор.Вставить("Тип", Перечисления.ТипыКонтактнойИнформации.Адрес);
	Отбор.Вставить("Вид", Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента);
	АдресЗапись = Контрагент.КонтактнаяИнформация.НайтиСтроки(Отбор);
	Если АдресЗапись.Количество() = 0 Тогда
		Возврат;
	Иначе
		АдресЗапись = АдресЗапись[0];
	КонецЕсли;
	АдресРег = АдресЗапись.ЗначенияПолей;
	СтруктураАдреса.Представление=АдресЗапись.Представление;	
	сч = 1;
	Если Лев(АдресРег,21) = "<КонтактнаяИнформация" Тогда
		АдресСтруктураXML = ЗаполнитьСтруктуруФайла(АдресЗапись.ЗначенияПолей);
		Попытка
			Если АдресСтруктураXML.Свойство("КонтактнаяИнформация") и АдресСтруктураXML.КонтактнаяИнформация.Свойство("Состав") и АдресСтруктураXML.КонтактнаяИнформация.Состав.Свойство("Состав") Тогда
				Если АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Свойство("ДопАдрЭл") Тогда
					Для Каждого АдрЭл Из АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.ДопАдрЭл Цикл
						Если АдрЭл.Свойство("ТипАдрЭл") и АдрЭл.ТипАдрЭл = "10100000" и АдрЭл.Свойство("Значение") Тогда
							СтруктураАдреса.Индекс = АдрЭл.Значение;
						ИначеЕсли АдрЭл.Свойство("Номер") и АдрЭл.Номер.Свойство("Тип") и АдрЭл.Номер.Свойство("Значение") Тогда
							Если АдрЭл.Номер.Тип = "1010" или АдрЭл.Номер.Тип = "1020" или АдрЭл.Номер.Тип = "1030" Тогда
								СтруктураАдреса.Дом = АдрЭл.Номер.Значение;
							ИначеЕсли АдрЭл.Номер.Тип = "1040" или АдрЭл.Номер.Тип = "1050" или АдрЭл.Номер.Тип = "1060" или АдрЭл.Номер.Тип = "1070" или АдрЭл.Номер.Тип = "1080" Тогда
								СтруктураАдреса.Корпус = АдрЭл.Номер.Значение;
							ИначеЕсли АдрЭл.Номер.Тип = "2010" или АдрЭл.Номер.Тип = "2020" или АдрЭл.Номер.Тип = "2030" или АдрЭл.Номер.Тип = "2040" или АдрЭл.Номер.Тип = "2050" Тогда
								СтруктураАдреса.Квартира = АдрЭл.Номер.Значение;
							КонецЕсли;
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
				Если АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Свойство("Город") Тогда
					Если ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Город) = Тип("Структура") и АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Город.Свойство("Параметр") Тогда
						СтруктураАдреса.Город = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Город.Параметр;
					ИначеЕсли ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Город) = Тип("Строка") Тогда
						СтруктураАдреса.Город = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Город;
					КонецЕсли;
				КонецЕсли;
				Если АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Свойство("СубъектРФ") Тогда
					Если ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СубъектРФ) = Тип("Структура") и АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СубъектРФ.Свойство("Параметр") Тогда
						СтруктураАдреса.Регион = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СубъектРФ.Параметр;
					ИначеЕсли ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СубъектРФ) = Тип("Строка") Тогда
						СтруктураАдреса.Регион = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СубъектРФ;
					КонецЕсли;
				КонецЕсли;
				Если АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Свойство("НаселПункт") Тогда
					Если ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.НаселПункт) = Тип("Структура") и АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.НаселПункт.Свойство("Параметр") Тогда
						СтруктураАдреса.НаселПункт = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.НаселПункт.Параметр;
					ИначеЕсли ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.НаселПункт) = Тип("Строка") Тогда
						СтруктураАдреса.НаселПункт = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.НаселПункт;
					КонецЕсли;
				КонецЕсли;
				Если АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Свойство("Улица") Тогда
					Если ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Улица) = Тип("Структура") и АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Улица.Свойство("Параметр") Тогда
						СтруктураАдреса.Улица = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Улица.Параметр;
					ИначеЕсли ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Улица) = Тип("Строка") Тогда
						СтруктураАдреса.Улица = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Улица;
					КонецЕсли;
				КонецЕсли;
				Если АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.Свойство("СвРайМО") и АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СвРайМО.Свойство("Район") Тогда
					Если ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СвРайМО.Район) = Тип("Структура") и АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СвРайМО.Район.Свойство("Параметр") Тогда
						СтруктураАдреса.Район = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СвРайМО.Район.Параметр;
					ИначеЕсли ТипЗнч(АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СвРайМО.Район) = Тип("Строка") Тогда
						СтруктураАдреса.Район = АдресСтруктураXML.КонтактнаяИнформация.Состав.Состав.СвРайМО.Район;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		Исключение
		КонецПопытки;                            
		
	Иначе
		Пока сч<=СтрЧислоСтрок(АдресРег) Цикл
			ЭлементАдреса = СтрПолучитьСтроку(АдресРег, сч);
			сч = сч+1;
			Если Найти(нрег(ЭлементАдреса), "индекс=") Тогда
				СтруктураАдреса.Индекс = Сред(ЭлементАдреса, 8);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "кодрегиона=") Тогда
				СтруктураАдреса.КодРегион = Сред(ЭлементАдреса, 12);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "регион=") Тогда
				СтруктураАдреса.Регион = Сред(ЭлементАдреса, 8);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "район=") Тогда
				СтруктураАдреса.Район = Сред(ЭлементАдреса, 7);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "город=") Тогда
				СтруктураАдреса.Город = Сред(ЭлементАдреса, 7);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "населенныйпункт=") Тогда
				СтруктураАдреса.НаселПункт = Сред(ЭлементАдреса, 17);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "улица=") Тогда
				СтруктураАдреса.Улица = Сред(ЭлементАдреса, 7);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "дом=") Тогда
				СтруктураАдреса.Дом = Сред(ЭлементАдреса, 5);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "корпус=") Тогда
				СтруктураАдреса.Корпус = Сред(ЭлементАдреса, 8);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "квартира=") Тогда
				СтруктураАдреса.Квартира = Сред(ЭлементАдреса, 10);
			ИначеЕсли Найти(нрег(ЭлементАдреса), "кодстраны=") Тогда
				СтруктураАдреса.КодСтраны = Сред(ЭлементАдреса, 11);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

