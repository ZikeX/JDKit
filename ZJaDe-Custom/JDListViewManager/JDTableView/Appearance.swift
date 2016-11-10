//
//  Appearance.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/18.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

typealias CellAppearanceClosure = (JDTableViewCell) -> ()

typealias ButtonAppearanceClosure = (Button) -> ()
typealias ButtonsSelectedAppearanceClosure = (Button,Int,Bool) -> ()
typealias TextFieldAppearanceClosure = (ComposeTextField) -> ()
typealias TextViewAppearanceClosure = (PlaceholderTextView) -> ()
typealias PickerViewAppearanceClosure = (UIPickerView) -> ()
typealias DatePickerAppearanceClosure = (UIDatePicker) -> ()
typealias SwitchAppearanceClosure = (UISwitch) -> ()
typealias LabelAppearanceClosure = (UILabel) -> ()
typealias ImgViewAppearanceClosure = (ImageView) -> ()


typealias LabelCellLayoutClosure = (UIStackView,UILabel) -> ()

typealias TextFieldCellLayoutClosure = (UIStackView,ComposeTextField) -> ()
typealias DoubleTextFieldCellLayoutClosure = (UIStackView,ComposeTextField,UILabel,ComposeTextField) -> ()

typealias TextViewCellLayoutClosure = (UIStackView,PlaceholderTextView) -> ()
