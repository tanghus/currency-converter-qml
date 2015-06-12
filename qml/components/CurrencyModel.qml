/*
  Copyright (C) 2013-2014 Thomas Tanghus
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
    CurrencyItem {code:'AFN'; numericCode:'971'; name:qsTr('Afghani'); countries: ['AFGHANISTAN']}
    CurrencyItem {code:'DZD'; numericCode:'012'; name:qsTr('Algerian Dinar'); countries: ['ALGERIA']}
    CurrencyItem {code:'ARS'; numericCode:'032'; name:qsTr('Argentine Peso'); countries: ['ARGENTINA']}
    CurrencyItem {code:'AMD'; numericCode:'051'; name:qsTr('Armenian Dram'); countries: ['ARMENIA']}
    CurrencyItem {code:'AWG'; numericCode:'533'; name:qsTr('Aruban Florin'); countries: ['ARUBA']}
    CurrencyItem {code:'AUD'; numericCode:'036'; name:qsTr('Australian Dollar'); countries: ['AUSTRALIA', 'CHRISTMAS ISLAND', 'COCOS (KEELING) ISLANDS', 'HEARD ISLAND AND MCDONALD ISLANDS', 'KIRIBATI', 'NAURU', 'NORFOLK ISLAND', 'TUVALU']}
    CurrencyItem {code:'AZN'; numericCode:'944'; name:qsTr('Azerbaijanian Manat'); countries: ['AZERBAIJAN']}
    CurrencyItem {code:'BSD'; numericCode:'044'; name:qsTr('Bahamian Dollar'); countries: ['BAHAMAS']}
    CurrencyItem {code:'BHD'; numericCode:'048'; name:qsTr('Bahraini Dinar'); countries: ['BAHRAIN']}
    CurrencyItem {code:'THB'; numericCode:'764'; name:qsTr('Baht'); countries: ['THAILAND']}
    CurrencyItem {code:'BBD'; numericCode:'052'; name:qsTr('Barbados Dollar'); countries: ['BARBADOS']}
    CurrencyItem {code:'BND'; numericCode:'096'; name:qsTr('Brunei Dollar'); countries: ['BRUNEI DARUSSALAM']}
    CurrencyItem {code:'BMD'; numericCode:'060'; name:qsTr('Bermudian Dollar'); countries: ['BERMUDA']}
    CurrencyItem {code:'BYR'; numericCode:'974'; name:qsTr('Belarussian Ruble'); countries: ['BELARUS']}
    CurrencyItem {code:'BZD'; numericCode:'084'; name:qsTr('Belize Dollar'); countries: ['BELIZE']}
    CurrencyItem {code:'VEF'; numericCode:'937'; name:qsTr('Bolivar Fuerte'); countries: ['VENEZUELA']}
    CurrencyItem {code:'BGN'; numericCode:'975'; name:qsTr('Bulgarian Lev'); countries: ['BULGARIA']}
    CurrencyItem {code:'BIF'; numericCode:'108'; name:qsTr('Burundi Franc'); countries: ['BURUNDI']}
    CurrencyItem {code:'BRL'; numericCode:'986'; name:qsTr('Brazilian Real'); countries: ['BRAZIL']}
    CurrencyItem {code:'CAD'; numericCode:'124'; name:qsTr('Canadian Dollar'); countries: ['CANADA']}
    CurrencyItem {code:'CVE'; numericCode:'132'; name:qsTr('Cape Verde Escudo'); countries: ['CAPE VERDE']}
    CurrencyItem {code:'KYD'; numericCode:'136'; name:qsTr('Cayman Islands Dollar'); countries: ['CAYMAN ISLANDS']}
    CurrencyItem {code:'XPF'; numericCode:'953'; name:qsTr('CFP Franc'); countries: ['FRENCH POLYNESIA', 'NEW CALEDONIA', 'WALLIS AND FUTUNA']}
    CurrencyItem {code:'CZK'; numericCode:'203'; name:qsTr('Czech Koruna'); countries: ['CZECH REPUBLIC']}
    CurrencyItem {code:'CLP'; numericCode:'152'; name:qsTr('Chilean Peso'); countries: ['CHILE']}
    CurrencyItem {code:'KMF'; numericCode:'174'; name:qsTr('Comoro Franc'); countries: ['COMOROS']}
    CurrencyItem {code:'BAM'; numericCode:'977'; name:qsTr('Convertible Marks'); countries: ['BOSNIA AND HERZEGOVINA']}
    CurrencyItem {code:'NIO'; numericCode:'558'; name:qsTr('Cordoba Oro'); countries: ['NICARAGUA']}
    CurrencyItem {code:'CRC'; numericCode:'188'; name:qsTr('Costa Rican Colon'); countries: ['COSTA RICA']}
    CurrencyItem {code:'COP'; numericCode:'170'; name:qsTr('Colombian Peso'); countries: ['COSTA RICA']}
    CurrencyItem {code:'HRK'; numericCode:'191'; name:qsTr('Croatian Kuna'); countries: ['CROATIA']}
    CurrencyItem {code:'CUP'; numericCode:'192'; name:qsTr('Cuban Peso'); countries: ['CUBA']}
    CurrencyItem {code:'GMD'; numericCode:'270'; name:qsTr('Dalasi'); countries: ['GAMBIA']}
    CurrencyItem {code:'DKK'; numericCode:'208'; name:qsTr('Danish Krone'); countries: ['DENMARK', 'FAROE ISLANDS', 'GREENLAND']}
    CurrencyItem {code:'MKD'; numericCode:'807'; name:qsTr('Denar'); countries: ['MACEDONIA']}
    CurrencyItem {code:'DJF'; numericCode:'262'; name:qsTr('Djibouti Franc'); countries: ['DJIBOUTI']}
    CurrencyItem {code:'DOP'; numericCode:'214'; name:qsTr('Dominican Peso'); countries: ['DOMINICAN REPUBLIC']}
    CurrencyItem {code:'VND'; numericCode:'704'; name:qsTr('Dong'); countries: ['VIET NAM']}
    CurrencyItem {code:'STD'; numericCode:'678'; name:qsTr('Dobra'); countries: ['SAO TOME AND PRINCIPE']}
    CurrencyItem {code:'XCD'; numericCode:'951'; name:qsTr('East Caribbean Dollar'); countries: ['ANGUILLA', 'ANTIGUA AND BARBUDA', 'DOMINICA', 'GRENADA', 'MONTSERRAT', 'SAINT KITTS AND NEVIS', 'SAINT LUCIA', 'SAINT VINCENT AND THE GRENADINES']}
    CurrencyItem {code:'EGP'; numericCode:'818'; name:qsTr('Egyptian Pound'); countries: ['EGYPT']}
    CurrencyItem {code:'ETB'; numericCode:'230'; name:qsTr('Ethiopian Birr'); countries: ['ETHIOPIA']}
    CurrencyItem {code:'EUR'; numericCode:'978'; name:qsTr('Euro'); symbol: "€"; countries: ['ANDORRA', 'AUSTRIA', 'BELGIUM', 'FINLAND', 'FRANCE', 'FRENCH GUIANA', 'FRENCH SOUTHERN TERRITORIES', 'GERMANY', 'GREECE', 'GUADELOUPE', 'IRELAND', 'ITALY', 'LUXEMBOURG', 'MARTINIQUE', 'MAYOTTE', 'MONACO', 'MONTENEGRO', 'NETHERLANDS', 'PORTUGAL', 'R.UNION', 'SAINT PIERRE AND MIQUELON', 'SAN MARINO', 'SLOVENIA', 'SPAIN']}
    CurrencyItem {code:'FKP'; numericCode:'238'; name:qsTr('Falkland Islands Pound'); countries: ['FALKLAND ISLANDS (MALVINAS)']}
    CurrencyItem {code:'FJD'; numericCode:'242'; name:qsTr('Fiji Dollar'); countries: ['FIJI']}
    CurrencyItem {code:'HUF'; numericCode:'348'; name:qsTr('Forint'); countries: ['HUNGARY']}
    CurrencyItem {code:'GHS'; numericCode:'936'; name:qsTr('Ghana Cedi'); countries: ['GHANA']}
    CurrencyItem {code:'GIP'; numericCode:'292'; name:qsTr('Gibraltar Pound'); countries: ['GIBRALTAR']}
    CurrencyItem {code:'XAU'; numericCode:'959'; name:qsTr('Gold'); countries: []}
//    CurrencyItem {code:'XFO'; numericCode:'Nil'; name:qsTr('Gold-Franc'); countries: []}
    CurrencyItem {code:'PYG'; numericCode:'600'; name:qsTr('Guarani'); countries: ['PARAGUAY']}
    CurrencyItem {code:'GNF'; numericCode:'324'; name:qsTr('Guinea Franc'); countries: ['GUINEA']}
    CurrencyItem {code:'GYD'; numericCode:'328'; name:qsTr('Guyana Dollar'); countries: ['GUYANA']}
    CurrencyItem {code:'HKD'; numericCode:'344'; name:qsTr('Hong Kong Dollar'); countries: ['HONG KONG']}
    CurrencyItem {code:'UAH'; numericCode:'980'; name:qsTr('Hryvnia'); countries: ['UKRAINE']}
    CurrencyItem {code:'ISK'; numericCode:'352'; name:qsTr('Iceland Krona'); countries: ['ICELAND']}
    CurrencyItem {code:'INR'; numericCode:'356'; name:qsTr('Indian Rupee'); countries: ['INDIA']}
    CurrencyItem {code:'IRR'; numericCode:'364'; name:qsTr('Iranian Rial'); countries: ['IRAN']}
    CurrencyItem {code:'IQD'; numericCode:'368'; name:qsTr('Iraqi Dinar'); countries: ['IRAQ']}
    CurrencyItem {code:'JMD'; numericCode:'388'; name:qsTr('Jamaican Dollar'); countries: ['JAMAICA']}
    CurrencyItem {code:'JOD'; numericCode:'400'; name:qsTr('Jordanian Dinar'); countries: ['JORDAN']}
    CurrencyItem {code:'KES'; numericCode:'404'; name:qsTr('Kenyan Shilling'); countries: ['KENYA']}
    CurrencyItem {code:'PGK'; numericCode:'598'; name:qsTr('Kina'); countries: ['PAPUA NEW GUINEA']}
    CurrencyItem {code:'LAK'; numericCode:'418'; name:qsTr('Kip'); countries: ['LAO PEOPLES DEMOCRATIC REPUBLIC']}
    //CurrencyItem {code:'EEK'; numericCode:'233'; name:qsTr('Kroon'); countries: ['ESTONIA']}
    CurrencyItem {code:'KWD'; numericCode:'414'; name:qsTr('Kuwaiti Dinar'); countries: ['KUWAIT']}
    CurrencyItem {code:'ZMK'; numericCode:'894'; name:qsTr('Zambian Kwacha'); countries: ['ZAMBIA']}
    CurrencyItem {code:'MWK'; numericCode:'454'; name:qsTr('Malawian Kwacha'); countries: ['MALAWI']}
    CurrencyItem {code:'AOA'; numericCode:'973'; name:qsTr('Kwanza'); countries: ['ANGOLA']}
    CurrencyItem {code:'MMK'; numericCode:'104'; name:qsTr('Kyat'); countries: ['MYANMAR']}
    CurrencyItem {code:'GEL'; numericCode:'981'; name:qsTr('Lari'); countries: ['GEORGIA']}
    //CurrencyItem {code:'LVL'; numericCode:'428'; name:qsTr('Latvian Lats'); countries: ['LATVIA']}
    CurrencyItem {code:'LBP'; numericCode:'422'; name:qsTr('Lebanese Pound'); countries: ['LEBANON']}
    CurrencyItem {code:'ALL'; numericCode:'008'; name:qsTr('Lek'); countries: ['ALBANIA']}
    CurrencyItem {code:'HNL'; numericCode:'340'; name:qsTr('Lempira'); countries: ['HONDURAS']}
    CurrencyItem {code:'SLL'; numericCode:'694'; name:qsTr('Leone'); countries: ['SIERRA LEONE']}
    CurrencyItem {code:'LRD'; numericCode:'430'; name:qsTr('Liberian Dollar'); countries: ['LIBERIA']}
    CurrencyItem {code:'SZL'; numericCode:'748'; name:qsTr('Lilangeni'); countries: ['SWAZILAND']}
    CurrencyItem {code:'LYD'; numericCode:'434'; name:qsTr('Libyan Dinar'); countries: ['LIBYAN ARAB JAMAHIRIYA']}
    // Lithuania uses Euro from 1 January 2015
    //CurrencyItem {code:'LTL'; numericCode:'440'; name:qsTr('Lithuanian Litas'); countries: ['LITHUANIA']}
    CurrencyItem {code:'MGA'; numericCode:'969'; name:qsTr('Malagasy Ariary'); countries: ['MADAGASCAR']}
    CurrencyItem {code:'MYR'; numericCode:'458'; name:qsTr('Malaysian Ringgit'); countries: ['MALAYSIA']}
    CurrencyItem {code:'TMM'; numericCode:'795'; name:qsTr('Manat'); countries: ['TURKMENISTAN']}
    CurrencyItem {code:'MUR'; numericCode:'480'; name:qsTr('Mauritius Rupee'); countries: ['MAURITIUS']}
    CurrencyItem {code:'MZN'; numericCode:'943'; name:qsTr('Metical'); countries: ['MOZAMBIQUE']}
    CurrencyItem {code:'MXN'; numericCode:'484'; name:qsTr('Mexican Peso'); countries: ['MEXICO']}
    CurrencyItem {code:'MDL'; numericCode:'498'; name:qsTr('Moldovan Leu'); countries: ['MOLDOVA']}
    CurrencyItem {code:'MAD'; numericCode:'504'; name:qsTr('Moroccan Dirham'); countries: ['MOROCCO', 'WESTERN SAHARA']}
    CurrencyItem {code:'NGN'; numericCode:'566'; name:qsTr('Naira'); countries: ['NIGERIA']}
    CurrencyItem {code:'ERN'; numericCode:'232'; name:qsTr('Nakfa'); countries: ['ERITREA']}
    CurrencyItem {code:'NPR'; numericCode:'524'; name:qsTr('Nepalese Rupee'); countries: ['NEPAL']}
    CurrencyItem {code:'ANG'; numericCode:'532'; name:qsTr('Netherlands Antillian Guilder'); countries: ['NETHERLANDS ANTILLES']}
    CurrencyItem {code:'ILS'; numericCode:'376'; name:qsTr('New Israeli Sheqel'); countries: ['ISRAEL']}
    CurrencyItem {code:'RON'; numericCode:'946'; name:qsTr('New Leu'); countries: ['ROMANIA']}
    CurrencyItem {code:'NZD'; numericCode:'554'; name:qsTr('New Zealand Dollar'); countries: ['COOK ISLANDS', 'NEW ZEALAND', 'NIUE', 'PITCAIRN', 'TOKELAU']}
    CurrencyItem {code:'TWD'; numericCode:'901'; name:qsTr('New Taiwan Dollar'); countries: ['TAIWAN']}
    CurrencyItem {code:'TRY'; numericCode:'949'; name:qsTr('Turkish Lira'); countries: ['TURKEY']}
    CurrencyItem {code:'KPW'; numericCode:'408'; name:qsTr('North Korean Won'); countries: ['KOREA']}
    CurrencyItem {code:'NOK'; numericCode:'578'; name:qsTr('Norwegian Krone'); countries: ['BOUVET ISLAND', 'NORWAY', 'SVALBARD AND JAN MAYEN']}
    CurrencyItem {code:'PEN'; numericCode:'604'; name:qsTr('Nuevo Sol'); countries: ['PERU']}
    CurrencyItem {code:'MRO'; numericCode:'478'; name:qsTr('Ouguiya'); countries: ['MAURITANIA']}
    CurrencyItem {code:'PKR'; numericCode:'586'; name:qsTr('Pakistan Rupee'); countries: ['PAKISTAN']}
    CurrencyItem {code:'XPD'; numericCode:'964'; name:qsTr('Palladium'); countries: []}
    CurrencyItem {code:'MOP'; numericCode:'446'; name:qsTr('Pataca'); countries: ['MACAO']}
    CurrencyItem {code:'PHP'; numericCode:'608'; name:qsTr('Philippine Peso'); countries: ['PHILIPPINES']}
    CurrencyItem {code:'XPT'; numericCode:'962'; name:qsTr('Platinum'); countries: []}
    CurrencyItem {code:'GBP'; numericCode:'826'; name:qsTr('Pound Sterling'); symbol: "£"; countries: ['UNITED KINGDOM']}
    CurrencyItem {code:'BWP'; numericCode:'072'; name:qsTr('Pula'); countries: ['BOTSWANA']}
    CurrencyItem {code:'QAR'; numericCode:'634'; name:qsTr('Qatari Rial'); countries: ['QATAR']}
    CurrencyItem {code:'GTQ'; numericCode:'320'; name:qsTr('Quetzal'); countries: ['GUATEMALA']}
    CurrencyItem {code:'TOP'; numericCode:'776'; name:qsTr('Paanga'); countries: ['TONGA']}
    CurrencyItem {code:'ZAR'; numericCode:'710'; name:qsTr('Rand'); countries: ['SOUTH AFRICA']}
    CurrencyItem {code:'OMR'; numericCode:'512'; name:qsTr('Rial Omani'); countries: ['OMAN']}
    CurrencyItem {code:'KHR'; numericCode:'116'; name:qsTr('Riel'); countries: ['CAMBODIA']}
    CurrencyItem {code:'MVR'; numericCode:'462'; name:qsTr('Rufiyaa'); countries: ['MALDIVES']}
    CurrencyItem {code:'IDR'; numericCode:'360'; name:qsTr('Rupiah'); countries: ['INDONESIA']}
    CurrencyItem {code:'RUB'; numericCode:'643'; name:qsTr('Russian Ruble'); countries: ['RUSSIAN FEDERATION']}
    CurrencyItem {code:'RWF'; numericCode:'646'; name:qsTr('Rwanda Franc'); countries: ['RWANDA']}
    CurrencyItem {code:'SHP'; numericCode:'654'; name:qsTr('Saint Helena Pound'); countries: ['SAINT HELENA']}
    CurrencyItem {code:'SAR'; numericCode:'682'; name:qsTr('Saudi Riyal'); countries: ['SAUDI ARABIA']}
    CurrencyItem {code:'XDR'; numericCode:'960'; name:qsTr('SDR'); countries: ['INTERNATIONAL MONETARY FUND (I.M.F)']}
    CurrencyItem {code:'SCR'; numericCode:'690'; name:qsTr('Seychelles Rupee'); countries: ['SEYCHELLES']}
    CurrencyItem {code:'RSD'; numericCode:'941'; name:qsTr('Serbian Dinar'); countries: ['SERBIA']}
    CurrencyItem {code:'XAG'; numericCode:'961'; name:qsTr('Silver'); countries: []}
    CurrencyItem {code:'SGD'; numericCode:'702'; name:qsTr('Singapore Dollar'); countries: ['SINGAPORE']}
    //CurrencyItem {code:'SKK'; numericCode:'703'; name:qsTr('Slovak Koruna'); countries: ['SLOVAKIA']}
    CurrencyItem {code:'SBD'; numericCode:'090'; name:qsTr('Solomon Islands Dollar'); countries: ['SOLOMON ISLANDS']}
    CurrencyItem {code:'TJS'; numericCode:'972'; name:qsTr('Somoni'); countries: ['TAJIKISTAN']}
    CurrencyItem {code:'KGS'; numericCode:'417'; name:qsTr('Som'); countries: ['KYRGYZSTAN']}
    CurrencyItem {code:'SOS'; numericCode:'706'; name:qsTr('Somali Shilling'); countries: ['SOMALIA']}
    CurrencyItem {code:'SSP'; numericCode:'728'; name:qsTr('South Sudanese Pound'); symbol: '£'; countries: ['SOUTH SUDAN']}
    CurrencyItem {code:'LKR'; numericCode:'144'; name:qsTr('Sri Lanka Rupee'); countries: ['SRI LANKA']}
    CurrencyItem {code:'SDG'; numericCode:'938'; name:qsTr('Sudanese Pound'); countries: ['SUDAN']}
    CurrencyItem {code:'SRD'; numericCode:'968'; name:qsTr('Surinam Dollar'); countries: ['SURINAME']}
    CurrencyItem {code:'SEK'; numericCode:'752'; name:qsTr('Swedish Krona'); countries: ['SWEDEN']}
    CurrencyItem {code:'CHF'; numericCode:'756'; name:qsTr('Swiss Franc'); countries: ['LIECHTENSTEIN']}
    CurrencyItem {code:'SYP'; numericCode:'760'; name:qsTr('Syrian Pound'); countries: ['SYRIAN ARAB REPUBLIC']}
    CurrencyItem {code:'TND'; numericCode:'788'; name:qsTr('Tunisian Dinar'); countries: ['TUNISIA']}
    CurrencyItem {code:'BDT'; numericCode:'050'; name:qsTr('Taka'); countries: ['BANGLADESH']}
    CurrencyItem {code:'WST'; numericCode:'882'; name:qsTr('Tala'); countries: ['SAMOA']}
    CurrencyItem {code:'TZS'; numericCode:'834'; name:qsTr('Tanzanian Shilling'); countries: ['TANZANIA']}
    CurrencyItem {code:'KZT'; numericCode:'398'; name:qsTr('Tenge'); countries: ['KAZAKHSTAN']}
    CurrencyItem {code:'TTD'; numericCode:'780'; name:qsTr('Trinidad and Tobago Dollar'); countries: ['TRINIDAD AND TOBAGO']}
    CurrencyItem {code:'MNT'; numericCode:'496'; name:qsTr('Tugrik'); countries: ['MONGOLIA']}
    CurrencyItem {code:'AED'; numericCode:'784'; name:qsTr('UAE Dirham'); countries: ['UNITED ARAB EMIRATES']}
    CurrencyItem {code:'USD'; numericCode:'840'; name:qsTr('US Dollar'); symbol: "$"; countries: ['AMERICAN SAMOA', 'BRITISH INDIAN OCEAN TERRITORY', 'ECUADOR', 'GUAM', 'MARSHALL ISLANDS', 'MICRONESIA', 'NORTHERN MARIANA ISLANDS', 'PALAU', 'PUERTO RICO', 'TIMOR-LESTE', 'TURKS AND CAICOS ISLANDS', 'UNITED STATES MINOR OUTLYING ISLANDS', 'VIRGIN ISLANDS (BRITISH)', 'VIRGIN ISLANDS (U.S.)']}
    CurrencyItem {code:'KRW'; numericCode:'410'; name:qsTr('Won'); countries: ['KOREA']}
    CurrencyItem {code:'JPY'; numericCode:'392'; name:qsTr('Yen'); countries: ['JAPAN']}
    CurrencyItem {code:'CNY'; numericCode:'156'; name:qsTr('Yuan Renminbi'); countries: ['CHINA']}
    CurrencyItem {code:'UGX'; numericCode:'800'; name:qsTr('Uganda Shilling'); countries: ['UGANDA']}
    CurrencyItem {code:'UZS'; numericCode:'860'; name:qsTr('Uzbekistan Sum'); countries: ['UZBEKISTAN']}
    CurrencyItem {code:'VUV'; numericCode:'548'; name:qsTr('Vatu'); countries: ['VANUATU']}
    CurrencyItem {code:'YER'; numericCode:'886'; name:qsTr('Yemeni Rial'); countries: ['YEMEN']}
    CurrencyItem {code:'ZWD'; numericCode:'716'; name:qsTr('Zimbabwe Dollar'); countries: ['ZIMBABWE']}
    CurrencyItem {code:'PLN'; numericCode:'985'; name:qsTr('Zloty'); countries: ['POLAND']}
}
