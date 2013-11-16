/*
  Copyright (C) 2013 Thomas Tanghus
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

VisualItemModel {
    id: currencyModel
    CurrencyItem {code:'AFN'; numericCode:'971'; name:'Afghani'; countries: ['AFGHANISTAN']}
    CurrencyItem {code:'DZD'; numericCode:'012'; name:'Algerian Dinar'; countries: ['ALGERIA']}
    CurrencyItem {code:'AMD'; numericCode:'051'; name:'Armenian Dram'; countries: ['ARMENIA']}
    CurrencyItem {code:'AWG'; numericCode:'533'; name:'Aruban Guilder'; countries: ['ARUBA']}
    CurrencyItem {code:'AZN'; numericCode:'944'; name:'Azerbaijanian Manat'; countries: ['AZERBAIJAN']}
    CurrencyItem {code:'BHD'; numericCode:'048'; name:'Bahraini Dinar'; countries: ['BAHRAIN']}
    CurrencyItem {code:'BND'; numericCode:'096'; name:'Brunei Dollar'; countries: ['BRUNEI DARUSSALAM']}
    CurrencyItem {code:'BMD'; numericCode:'060'; name:'Bermudian Dollar'; countries: ['BERMUDA']}
    CurrencyItem {code:'BYR'; numericCode:'974'; name:'Belarussian Ruble'; countries: ['BELARUS']}
    CurrencyItem {code:'BZD'; numericCode:'084'; name:'Belize Dollar'; countries: ['BELIZE']}
    CurrencyItem {code:'BIF'; numericCode:'108'; name:'Burundi Franc'; countries: ['BURUNDI']}
    CurrencyItem {code:'BRL'; numericCode:'986'; name:'Brazilian Real'; countries: ['BRAZIL']}
    CurrencyItem {code:'CAD'; numericCode:'124'; name:'Canadian Dollar'; countries: ['CANADA']}
    CurrencyItem {code:'CVE'; numericCode:'132'; name:'Cape Verde Escudo'; countries: ['CAPE VERDE']}
    CurrencyItem {code:'KMF'; numericCode:'174'; name:'Comoro Franc'; countries: ['COMOROS']}
    CurrencyItem {code:'BAM'; numericCode:'977'; name:'Convertible Marks'; countries: ['BOSNIA AND HERZEGOVINA']}
    CurrencyItem {code:'CRC'; numericCode:'188'; name:'Costa Rican Colon'; countries: ['COSTA RICA']}
    CurrencyItem {code:'COP'; numericCode:'170'; name:'Colombian Peso'; countries: ['COSTA RICA']}
    CurrencyItem {code:'DKK'; numericCode:'208'; name:'Danish Krone'; countries: ['DENMARK', 'FAROE ISLANDS', 'GREENLAND']}
    CurrencyItem {code:'ETB'; numericCode:'230'; name:'Ethiopian Birr'; countries: ['ETHIOPIA']}
    CurrencyItem {code:'PYG'; numericCode:'600'; name:'Guarani'; countries: ['PARAGUAY']}
    CurrencyItem {code:'ERN'; numericCode:'232'; name:'Nakfa'; countries: ['ERITREA']}
    CurrencyItem {code:'LAK'; numericCode:'418'; name:'Kip'; countries: ['LAO PEOPLES DEMOCRATIC REPUBLIC']}
    CurrencyItem {code:'MMK'; numericCode:'104'; name:'Kyat'; countries: ['MYANMAR']}
    CurrencyItem {code:'LRD'; numericCode:'430'; name:'Liberian Dollar'; countries: ['LIBERIA']}
    CurrencyItem {code:'MUR'; numericCode:'480'; name:'Mauritius Rupee'; countries: ['MAURITIUS']}
    CurrencyItem {code:'NGN'; numericCode:'566'; name:'Naira'; countries: ['NIGERIA']}
    CurrencyItem {code:'MOP'; numericCode:'446'; name:'Pataca'; countries: ['MACAO']}
    CurrencyItem {code:'IDR'; numericCode:'360'; name:'Rupiah'; countries: ['INDONESIA']}
    CurrencyItem {code:'KGS'; numericCode:'417'; name:'Som'; countries: ['KYRGYZSTAN']}
    CurrencyItem {code:'GTQ'; numericCode:'320'; name:'Quetzal'; countries: ['GUATEMALA']}
    CurrencyItem {code:'TTD'; numericCode:'780'; name:'Trinidad and Tobago Dollar'; countries: ['TRINIDAD AND TOBAGO']}
    CurrencyItem {code:'PKR'; numericCode:'586'; name:'Pakistan Rupee'; countries: ['PAKISTAN']}
    CurrencyItem {code:'UZS'; numericCode:'860'; name:'Uzbekistan Sum'; countries: ['UZBEKISTAN']}
    CurrencyItem {code:'XCD'; numericCode:'951'; name:'East Caribbean Dollar'; countries: ['ANGUILLA', 'ANTIGUA AND BARBUDA', 'DOMINICA', 'GRENADA', 'MONTSERRAT', 'SAINT KITTS AND NEVIS', 'SAINT LUCIA', 'SAINT VINCENT AND THE GRENADINES']}
    CurrencyItem {code:'VUV'; numericCode:'548'; name:'Vatu'; countries: ['VANUATU']}
    CurrencyItem {code:'XPD'; numericCode:'964'; name:'Palladium'; countries: []}
    CurrencyItem {code:'MNT'; numericCode:'496'; name:'Tugrik'; countries: ['MONGOLIA']}
    CurrencyItem {code:'ANG'; numericCode:'532'; name:'Netherlands Antillian Guilder'; countries: ['NETHERLANDS ANTILLES']}
    CurrencyItem {code:'LBP'; numericCode:'422'; name:'Lebanese Pound'; countries: ['LEBANON']}
    CurrencyItem {code:'KES'; numericCode:'404'; name:'Kenyan Shilling'; countries: ['KENYA']}
    CurrencyItem {code:'GBP'; numericCode:'826'; name:'Pound Sterling'; symbol: "£"; countries: ['UNITED KINGDOM']}
    CurrencyItem {code:'SEK'; numericCode:'752'; name:'Swedish Krona'; countries: ['SWEDEN']}
    CurrencyItem {code:'KZT'; numericCode:'398'; name:'Tenge'; countries: ['KAZAKHSTAN']}
    CurrencyItem {code:'ZMK'; numericCode:'894'; name:'Kwacha'; countries: ['ZAMBIA']}
    CurrencyItem {code:'SKK'; numericCode:'703'; name:'Slovak Koruna'; countries: ['SLOVAKIA']}
    CurrencyItem {code:'TMM'; numericCode:'795'; name:'Manat'; countries: ['TURKMENISTAN']}
    CurrencyItem {code:'SCR'; numericCode:'690'; name:'Seychelles Rupee'; countries: ['SEYCHELLES']}
    CurrencyItem {code:'FJD'; numericCode:'242'; name:'Fiji Dollar'; countries: ['FIJI']}
    CurrencyItem {code:'SHP'; numericCode:'654'; name:'Saint Helena Pound'; countries: ['SAINT HELENA']}
    CurrencyItem {code:'ALL'; numericCode:'008'; name:'Lek'; countries: ['ALBANIA']}
    CurrencyItem {code:'TOP'; numericCode:'776'; name:'Paanga'; countries: ['TONGA']}
    CurrencyItem {code:'UGX'; numericCode:'800'; name:'Uganda Shilling'; countries: ['UGANDA']}
    CurrencyItem {code:'OMR'; numericCode:'512'; name:'Rial Omani'; countries: ['OMAN']}
    CurrencyItem {code:'DJF'; numericCode:'262'; name:'Djibouti Franc'; countries: ['DJIBOUTI']}
    CurrencyItem {code:'TND'; numericCode:'788'; name:'Tunisian Dinar'; countries: ['TUNISIA']}
    CurrencyItem {code:'SBD'; numericCode:'090'; name:'Solomon Islands Dollar'; countries: ['SOLOMON ISLANDS']}
    CurrencyItem {code:'GHS'; numericCode:'936'; name:'Ghana Cedi'; countries: ['GHANA']}
    CurrencyItem {code:'GNF'; numericCode:'324'; name:'Guinea Franc'; countries: ['GUINEA']}
    CurrencyItem {code:'ARS'; numericCode:'032'; name:'Argentine Peso'; countries: ['ARGENTINA']}
    CurrencyItem {code:'CLP'; numericCode:'152'; name:'Chilean Peso'; countries: ['CHILE']}
    CurrencyItem {code:'GMD'; numericCode:'270'; name:'Dalasi'; countries: ['GAMBIA']}
    CurrencyItem {code:'ZWD'; numericCode:'716'; name:'Zimbabwe Dollar'; countries: ['ZIMBABWE']}
    CurrencyItem {code:'MWK'; numericCode:'454'; name:'Kwacha'; countries: ['MALAWI']}
    CurrencyItem {code:'BDT'; numericCode:'050'; name:'Taka'; countries: ['BANGLADESH']}
    CurrencyItem {code:'KWD'; numericCode:'414'; name:'Kuwaiti Dinar'; countries: ['KUWAIT']}
    CurrencyItem {code:'EUR'; numericCode:'978'; name:'Euro'; symbol: "€"; countries: ['ANDORRA', 'AUSTRIA', 'BELGIUM', 'FINLAND', 'FRANCE', 'FRENCH GUIANA', 'FRENCH SOUTHERN TERRITORIES', 'GERMANY', 'GREECE', 'GUADELOUPE', 'IRELAND', 'ITALY', 'LUXEMBOURG', 'MARTINIQUE', 'MAYOTTE', 'MONACO', 'MONTENEGRO', 'NETHERLANDS', 'PORTUGAL', 'R.UNION', 'SAINT PIERRE AND MIQUELON', 'SAN MARINO', 'SLOVENIA', 'SPAIN']}
    CurrencyItem {code:'MXN'; numericCode:'484'; name:'Mexican Peso'; countries: ['MEXICO']}
    CurrencyItem {code:'CHF'; numericCode:'756'; name:'Swiss Franc'; countries: ['LIECHTENSTEIN']}
    CurrencyItem {code:'XAG'; numericCode:'961'; name:'Silver'; countries: []}
    CurrencyItem {code:'SRD'; numericCode:'968'; name:'Surinam Dollar'; countries: ['SURINAME']}
    CurrencyItem {code:'DOP'; numericCode:'214'; name:'Dominican Peso'; countries: ['DOMINICAN REPUBLIC']}
    CurrencyItem {code:'PEN'; numericCode:'604'; name:'Nuevo Sol'; countries: ['PERU']}
    CurrencyItem {code:'KPW'; numericCode:'408'; name:'North Korean Won'; countries: ['KOREA']}
    CurrencyItem {code:'SGD'; numericCode:'702'; name:'Singapore Dollar'; countries: ['SINGAPORE']}
    CurrencyItem {code:'TWD'; numericCode:'901'; name:'New Taiwan Dollar'; countries: ['TAIWAN']}
    CurrencyItem {code:'USD'; numericCode:'840'; name:'US Dollar'; symbol: "$"; countries: ['AMERICAN SAMOA', 'BRITISH INDIAN OCEAN TERRITORY', 'ECUADOR', 'GUAM', 'MARSHALL ISLANDS', 'MICRONESIA', 'NORTHERN MARIANA ISLANDS', 'PALAU', 'PUERTO RICO', 'TIMOR-LESTE', 'TURKS AND CAICOS ISLANDS', 'UNITED STATES MINOR OUTLYING ISLANDS', 'VIRGIN ISLANDS (BRITISH)', 'VIRGIN ISLANDS (U.S.)']}
    CurrencyItem {code:'BGN'; numericCode:'975'; name:'Bulgarian Lev'; countries: ['BULGARIA']}
    CurrencyItem {code:'MAD'; numericCode:'504'; name:'Moroccan Dirham'; countries: ['MOROCCO', 'WESTERN SAHARA']}
    CurrencyItem {code:'SAR'; numericCode:'682'; name:'Saudi Riyal'; countries: ['SAUDI ARABIA']}
    CurrencyItem {code:'AUD'; numericCode:'036'; name:'Australian Dollar'; countries: ['AUSTRALIA', 'CHRISTMAS ISLAND', 'COCOS (KEELING) ISLANDS', 'HEARD ISLAND AND MCDONALD ISLANDS', 'KIRIBATI', 'NAURU', 'NORFOLK ISLAND', 'TUVALU']}
    CurrencyItem {code:'KYD'; numericCode:'136'; name:'Cayman Islands Dollar'; countries: ['CAYMAN ISLANDS']}
    CurrencyItem {code:'KRW'; numericCode:'410'; name:'Won'; countries: ['KOREA']}
    CurrencyItem {code:'GIP'; numericCode:'292'; name:'Gibraltar Pound'; countries: ['GIBRALTAR']}
    CurrencyItem {code:'TRY'; numericCode:'949'; name:'New Turkish Lira'; countries: ['TURKEY']}
    CurrencyItem {code:'XAU'; numericCode:'959'; name:'Gold'; countries: []}
    CurrencyItem {code:'CZK'; numericCode:'203'; name:'Czech Koruna'; countries: ['CZECH REPUBLIC']}
    CurrencyItem {code:'JMD'; numericCode:'388'; name:'Jamaican Dollar'; countries: ['JAMAICA']}
    CurrencyItem {code:'BSD'; numericCode:'044'; name:'Bahamian Dollar'; countries: ['BAHAMAS']}
    CurrencyItem {code:'BWP'; numericCode:'072'; name:'Pula'; countries: ['BOTSWANA']}
    CurrencyItem {code:'GYD'; numericCode:'328'; name:'Guyana Dollar'; countries: ['GUYANA']}
    CurrencyItem {code:'LYD'; numericCode:'434'; name:'Libyan Dinar'; countries: ['LIBYAN ARAB JAMAHIRIYA']}
    CurrencyItem {code:'EGP'; numericCode:'818'; name:'Egyptian Pound'; countries: ['EGYPT']}
    CurrencyItem {code:'THB'; numericCode:'764'; name:'Baht'; countries: ['THAILAND']}
    CurrencyItem {code:'MKD'; numericCode:'807'; name:'Denar'; countries: ['MACEDONIA']}
    CurrencyItem {code:'SDG'; numericCode:'938'; name:'Sudanese Pound'; countries: ['SUDAN']}
    CurrencyItem {code:'AED'; numericCode:'784'; name:'UAE Dirham'; countries: ['UNITED ARAB EMIRATES']}
    CurrencyItem {code:'JOD'; numericCode:'400'; name:'Jordanian Dinar'; countries: ['JORDAN']}
    CurrencyItem {code:'JPY'; numericCode:'392'; name:'Yen'; countries: ['JAPAN']}
    CurrencyItem {code:'ZAR'; numericCode:'710'; name:'Rand'; countries: ['SOUTH AFRICA']}
    CurrencyItem {code:'HRK'; numericCode:'191'; name:'Croatian Kuna'; countries: ['CROATIA']}
    CurrencyItem {code:'AOA'; numericCode:'973'; name:'Kwanza'; countries: ['ANGOLA']}
    CurrencyItem {code:'RWF'; numericCode:'646'; name:'Rwanda Franc'; countries: ['RWANDA']}
    CurrencyItem {code:'CUP'; numericCode:'192'; name:'Cuban Peso'; countries: ['CUBA']}
    CurrencyItem {code:'XFO'; numericCode:'Nil'; name:'Gold-Franc'; countries: []}
    CurrencyItem {code:'BBD'; numericCode:'052'; name:'Barbados Dollar'; countries: ['BARBADOS']}
    CurrencyItem {code:'PGK'; numericCode:'598'; name:'Kina'; countries: ['PAPUA NEW GUINEA']}
    CurrencyItem {code:'LKR'; numericCode:'144'; name:'Sri Lanka Rupee'; countries: ['SRI LANKA']}
    CurrencyItem {code:'RON'; numericCode:'946'; name:'New Leu'; countries: ['ROMANIA']}
    CurrencyItem {code:'PLN'; numericCode:'985'; name:'Zloty'; countries: ['POLAND']}
    CurrencyItem {code:'IQD'; numericCode:'368'; name:'Iraqi Dinar'; countries: ['IRAQ']}
    CurrencyItem {code:'TJS'; numericCode:'972'; name:'Somoni'; countries: ['TAJIKISTAN']}
    CurrencyItem {code:'MDL'; numericCode:'498'; name:'Moldovan Leu'; countries: ['MOLDOVA']}
    CurrencyItem {code:'MYR'; numericCode:'458'; name:'Malaysian Ringgit'; countries: ['MALAYSIA']}
    CurrencyItem {code:'CNY'; numericCode:'156'; name:'Yuan Renminbi'; countries: ['CHINA']}
    CurrencyItem {code:'LVL'; numericCode:'428'; name:'Latvian Lats'; countries: ['LATVIA']}
    CurrencyItem {code:'INR'; numericCode:'356'; name:'Indian Rupee'; countries: ['INDIA']}
    CurrencyItem {code:'FKP'; numericCode:'238'; name:'Falkland Islands Pound'; countries: ['FALKLAND ISLANDS (MALVINAS)']}
    CurrencyItem {code:'NIO'; numericCode:'558'; name:'Cordoba Oro'; countries: ['NICARAGUA']}
    CurrencyItem {code:'PHP'; numericCode:'608'; name:'Philippine Peso'; countries: ['PHILIPPINES']}
    CurrencyItem {code:'HNL'; numericCode:'340'; name:'Lempira'; countries: ['HONDURAS']}
    CurrencyItem {code:'HKD'; numericCode:'344'; name:'Hong Kong Dollar'; countries: ['HONG KONG']}
    CurrencyItem {code:'NZD'; numericCode:'554'; name:'New Zealand Dollar'; countries: ['COOK ISLANDS', 'NEW ZEALAND', 'NIUE', 'PITCAIRN', 'TOKELAU']}
    CurrencyItem {code:'RSD'; numericCode:'941'; name:'Serbian Dinar'; countries: ['SERBIA']}
    CurrencyItem {code:'EEK'; numericCode:'233'; name:'Kroon'; countries: ['ESTONIA']}
    CurrencyItem {code:'SOS'; numericCode:'706'; name:'Somali Shilling'; countries: ['SOMALIA']}
    CurrencyItem {code:'MZN'; numericCode:'943'; name:'Metical'; countries: ['MOZAMBIQUE']}
    CurrencyItem {code:'NOK'; numericCode:'578'; name:'Norwegian Krone'; countries: ['BOUVET ISLAND', 'NORWAY', 'SVALBARD AND JAN MAYEN']}
    CurrencyItem {code:'ISK'; numericCode:'352'; name:'Iceland Krona'; countries: ['ICELAND']}
    CurrencyItem {code:'GEL'; numericCode:'981'; name:'Lari'; countries: ['GEORGIA']}
    CurrencyItem {code:'ILS'; numericCode:'376'; name:'New Israeli Sheqel'; countries: ['ISRAEL']}
    CurrencyItem {code:'HUF'; numericCode:'348'; name:'Forint'; countries: ['HUNGARY']}
    CurrencyItem {code:'UAH'; numericCode:'980'; name:'Hryvnia'; countries: ['UKRAINE']}
    CurrencyItem {code:'RUB'; numericCode:'643'; name:'Russian Ruble'; countries: ['RUSSIAN FEDERATION']}
    CurrencyItem {code:'IRR'; numericCode:'364'; name:'Iranian Rial'; countries: ['IRAN']}
    CurrencyItem {code:'MGA'; numericCode:'969'; name:'Malagasy Ariary'; countries: ['MADAGASCAR']}
    CurrencyItem {code:'MVR'; numericCode:'462'; name:'Rufiyaa'; countries: ['MALDIVES']}
    CurrencyItem {code:'QAR'; numericCode:'634'; name:'Qatari Rial'; countries: ['QATAR']}
    CurrencyItem {code:'VND'; numericCode:'704'; name:'Dong'; countries: ['VIET NAM']}
    CurrencyItem {code:'MRO'; numericCode:'478'; name:'Ouguiya'; countries: ['MAURITANIA']}
    CurrencyItem {code:'NPR'; numericCode:'524'; name:'Nepalese Rupee'; countries: ['NEPAL']}
    CurrencyItem {code:'KHR'; numericCode:'116'; name:'Riel'; countries: ['CAMBODIA']}
    CurrencyItem {code:'SLL'; numericCode:'694'; name:'Leone'; countries: ['SIERRA LEONE']}
    CurrencyItem {code:'STD'; numericCode:'678'; name:'Dobra'; countries: ['SAO TOME AND PRINCIPE']}
    CurrencyItem {code:'SYP'; numericCode:'760'; name:'Syrian Pound'; countries: ['SYRIAN ARAB REPUBLIC']}
    CurrencyItem {code:'SZL'; numericCode:'748'; name:'Lilangeni'; countries: ['SWAZILAND']}
    CurrencyItem {code:'TZS'; numericCode:'834'; name:'Tanzanian Shilling'; countries: ['TANZANIA']}
    CurrencyItem {code:'LTL'; numericCode:'440'; name:'Lithuanian Litas'; countries: ['LITHUANIA']}
    CurrencyItem {code:'VEF'; numericCode:'937'; name:'Bolivar Fuerte'; countries: ['VENEZUELA']}
    CurrencyItem {code:'WST'; numericCode:'882'; name:'Tala'; countries: ['SAMOA']}
    CurrencyItem {code:'XDR'; numericCode:'960'; name:'SDR'; countries: ['INTERNATIONAL MONETARY FUND (I.M.F)']}
    CurrencyItem {code:'XPF'; numericCode:'953'; name:'CFP Franc'; countries: ['FRENCH POLYNESIA', 'NEW CALEDONIA', 'WALLIS AND FUTUNA']}
    CurrencyItem {code:'XPT'; numericCode:'962'; name:'Platinum'; countries: []}
    CurrencyItem {code:'YER'; numericCode:'886'; name:'Yemeni Rial'; countries: ['YEMEN']}
}
