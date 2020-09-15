class DynamicFormPojo {
  double margin;
  List<FormChild> form;

  DynamicFormPojo({this.form});

  DynamicFormPojo.fromJson(Map<String, dynamic> json) {
    margin = json['margin'];
    if (json['form'] != null) {
      form = new List<FormChild>();
      json['form'].forEach((v) {
        form.add(new FormChild.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['margin'] = this.margin;
    if (this.form != null) {
      data['form'] = this.form.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormChild {
  String type;
  String key;
  String label;
  double textSize;
  double child_size;
  String fontStyle;
  String fontWeight;
  String textColor;
  String textAlign;
  bool marginAll;
  List<double> margin;
  double marginValue;
  String hint;
  String borderColor;
  double borderWidth;
  double borderRadious;
  bool seticon;
  bool prefix;
  bool initialValue;
  bool suffix;
  bool allCaps;
  String errorMsg;
  double maxLength;
  String inputType;
  List<String> radioOption;
  List<RowData> row;
  bool allowEmpty;

  FormChild(
      {this.type,
      this.key,
      this.label,
      this.textSize,
      this.fontStyle,
      this.fontWeight,
      this.textColor,
      this.textAlign,
      this.marginAll,
      this.margin,
      this.marginValue,
      this.borderColor,
      this.borderWidth,
      this.borderRadious,
      this.seticon,
      this.prefix,
      this.suffix,
      this.errorMsg,
      this.maxLength,
      this.inputType,
      this.initialValue,
      this.radioOption,
      this.child_size,
      this.allCaps,
        this.allowEmpty,
        this.row});

  FormChild.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    key = json['key'];
    label = json['label'];
    textSize = json['text_size'] == null ? 14.0 : json['text_size'];
    fontStyle = json['font_style'];
    fontWeight = json['font_weight'] == null ? 'w200' : json['font_weight'];
    textColor = json['text_color'] == null ? '0xffffff' : json['text_color'];
    textAlign = json['textAlign'] == null ? 'left' : json['textAlign'];
    marginAll = json['margin_all'];

    if(json['margin']!=null)
      {
        margin = json['margin'].cast<double>();
      }

    marginValue = json['margin_value'];
    hint = json['hint'];
    borderColor = json['border_color'];
    borderWidth = json['border_width'];
    borderRadious = json['border_radious'];
    seticon = json['seticon'];
    prefix = json['prefix'];
    suffix = json['suffix'];
    errorMsg = json['error_msg'];
    maxLength = json['max_length'];
    inputType = json['input_type'];
    initialValue = json['initialValue'];
    child_size = json['child_size'];
    allCaps = json['allCaps']??false;
    allowEmpty = json['allowEmpty']??false;
    radioOption = json['radio_option']== null ? null :json['radio_option'].cast<String>();
    if (json['row'] != null) {
      row = new List<RowData>();
      json['row'].forEach((v) {
        row.add(new RowData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['key'] = this.key;
    data['label'] = this.label;
    data['text_size'] = this.textSize;
    data['font_style'] = this.fontStyle;
    data['font_weight'] = this.fontWeight;
    data['text_color'] = this.textColor;
    data['textAlign'] = this.textAlign;
    data['margin_all'] = this.marginAll;
    data['margin'] = this.margin;
    data['margin_value'] = this.marginValue;
    data['hint'] = this.hint;
    data['border_color'] = this.borderColor;
    data['border_width'] = this.borderWidth;
    data['border_radious'] = this.borderRadious;
    data['seticon'] = this.seticon;
    data['prefix'] = this.prefix;
    data['suffix'] = this.suffix;
    data['error_msg'] = this.errorMsg;
    data['max_length'] = this.maxLength;
    data['input_type'] = this.inputType;
    data['initialValue'] = this.initialValue;
    data['radio_option'] = this.radioOption;
    data['child_size'] = this.child_size;
    data['allCaps'] = this.allCaps;
    data['allowEmpty'] = this.allowEmpty;
    if (this.row != null) {
      data['row'] = this.row.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class RowData {
  String type;
  String key;
  String label;
  String hint;
  double textSize;
  String fontStyle;
  String fontWeight;
  String textColor;
  String borderColor;
  double borderWidth;
  double borderRadious;
  String textAlign;
  bool marginAll;
  double marginValue;
  String errorMsg;
  double maxLength;
  String inputType;
  List<double> margin;

  RowData(
      {this.type,
        this.key,
        this.label,
        this.hint,
        this.textSize,
        this.fontStyle,
        this.fontWeight,
        this.textColor,
        this.borderColor,
        this.borderWidth,
        this.borderRadious,
        this.textAlign,
        this.marginAll,
        this.marginValue,
        this.errorMsg,
        this.maxLength,
        this.margin,
        this.inputType});

  RowData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    key = json['key'];
    label = json['label'];
    hint = json['hint'];

    textSize = json['text_size'] == null ? 14.0 : json['text_size'];
    fontStyle = json['font_style'];
    fontWeight = json['font_weight'] == null ? 'w200' : json['font_weight'];
    textColor = json['text_color'] == null ? '0xffffff' : json['text_color'];
    textAlign = json['textAlign'] == null ? 'left' : json['textAlign'];
    borderColor = json['border_color'];
    borderWidth = json['border_width'];
    borderRadious = json['border_radious'];
    marginAll = json['margin_all'];
    marginValue = json['margin_value'];
    errorMsg = json['error_msg'];
    maxLength = json['max_length'];
    inputType = json['input_type'];
    if(json['margin']!=null)
    {
      margin = json['margin'].cast<double>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['key'] = this.key;
    data['label'] = this.label;
    data['hint'] = this.hint;
    data['text_size'] = this.textSize;
    data['font_style'] = this.fontStyle;
    data['font_weight'] = this.fontWeight;
    data['text_color'] = this.textColor;
    data['border_color'] = this.borderColor;
    data['border_width'] = this.borderWidth;
    data['border_radious'] = this.borderRadious;
    data['textAlign'] = this.textAlign;
    data['margin_all'] = this.marginAll;
    data['margin_value'] = this.marginValue;
    data['error_msg'] = this.errorMsg;
    data['max_length'] = this.maxLength;
    data['input_type'] = this.inputType;
    data['margin'] = this.margin;
    return data;
  }
}
