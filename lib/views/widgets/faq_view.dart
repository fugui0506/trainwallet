
import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqView extends StatelessWidget {
  const FaqView({
    super.key,
    required this.faqList,
    this.isShowTitle = true,
    });
  // FAQ 数据数组，需要 getx 数据
  final Rx<FaqListModel> faqList;

  // 选中下标
  // 需要传入一个 getx 数组
  // final RxList<int> faqIndex;

  // 是否展示 title
  // 默认展示
  final bool isShowTitle;

  @override
  Widget build(BuildContext context) {

    // 第一位：FAQ 对应的下标
    // 第二位：是否展开 0:不展开 1:展开
    final faqIndex = [-1, 0].obs;

    final loadingFaqs = [
      for (int i = 0; i < 20; i++)
        _buildEmpty(context),
    ];

    final title = Row(children: [
      Theme.of(context).myIcons.helpTitleIcon,
      const SizedBox(width: 8),
      Text(Lang.faqTitle.tr, style: Theme.of(context).myStyles.faqViewTitle)
    ]);
    
    return MyCard.normal(
      padding: const EdgeInsets.all(16),
      context: context,
      child: Obx(() => Column(
        children: [
          if (isShowTitle) title,
          if (isShowTitle) const SizedBox(height: 16),
          if (faqList.value.list.isEmpty)
            ...loadingFaqs
          else
            ...faqList.value.list.asMap().entries.map((e) => _buildFaqBox(context, e.value, e.key, faqIndex))
        ],
      )),
    );
  }

  Widget _buildEmpty(BuildContext context){
    return Theme.of(context).myIcons.loading(
      width: double.infinity,
      height: 40,
      radius: 10,
      margin: const EdgeInsets.only(bottom: 10)
    );
  }

  Widget _buildFaqBox(
    BuildContext context,
    FaqModel element,
    int index,
    RxList<int> faqIndex,
  ) {
    final hot = Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(width: 60, height: 22, child: Theme.of(context).myIcons.helpHot),
        SizedBox(width: 60, height: 22, child: Center(child: Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), child: FittedBox(child: Text(Lang.faqHot.tr, style: Theme.of(context).myStyles.onButton))))),
      ],
    );

    final normal = Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(width: 60, height: 22, child: Theme.of(context).myIcons.helpNormal),
        SizedBox(width: 60, height: 22, child: Center(child: Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), child: FittedBox(child: Text(Lang.faqNormal.tr, style: Theme.of(context).myStyles.onButton))))),
      ],
    );

    final titleButton = MyButton.widget(
      onPressed: () {
        if (faqIndex[0] == index) {
          if (faqIndex[1] == 0) {
            faqIndex[1] = 1;
          } else {
            faqIndex[0] = -1;
            faqIndex[1] = 0;
          }
        } else {
          faqIndex[0] = index;
          faqIndex[1] = 1;
        }
      },
      child: MyCard.faq(context: context, padding: const EdgeInsets.fromLTRB(16, 10, 16, 10), child: Row(
        children: [
          Expanded(child: Row(children: [
            Flexible(child: Text('${index + 1}.  ${element.name}',
              style: Theme.of(context).myStyles.faqTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
            // const SizedBox(width: 10),
            if (element.mark != 0)
              element.mark == 2 ? hot : normal,
          ])),
          const SizedBox(width: 10),
          Obx(() => Icon(
            faqIndex[0] == index && faqIndex[1] == 1 ? Icons.keyboard_control_key : Icons.keyboard_arrow_down,
            size: 20,
            color: Theme.of(context).myColors.textDefault,
          )),
        ],
      )),
    );

    final content = Obx(() => faqIndex[0] == index && faqIndex[1] == 1
      ? MyCard.faq(padding: const EdgeInsets.fromLTRB(16, 6, 16 , 16), context: context, child: element.type == 0
        ? Text(element.describe, style: Theme.of(context).myStyles.content)
        : MyImage(
            imageUrl: element.describe,
            width: Get.width - 16 - 16,
            fit: BoxFit.fitWidth,
          ))
      : const SizedBox()
    );

    return MyCard.faq(context: context, margin: const EdgeInsets.only(bottom: 6), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [titleButton, content],
    ));
  }
}