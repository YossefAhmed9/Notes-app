import 'package:flutter/material.dart';


//Default TextForm-field
class DefaultTextFormField {
  //final Key? key;
  final TextInputType keyboard;
  final TextEditingController controller;
  Function? submit;
  Function? change;
  Function? tap;
  final String label;
  final OutlinedBorder border;
  final Icon prefix;
  final Function(String?)? validate;

  DefaultTextFormField(
    // this.key,
    this.submit,
    this.change,
    this.tap,
    this.validate, {
    required this.keyboard,
    required this.controller,
    required this.label,
    required this.border,
    required this.prefix,
  });
}

Widget defaultTextFormField(
  // final Key? key,
  final TextInputType keyboard,
  final TextEditingController controller,
  final Function(String?) submit,
  final Function(String?) change,
  final GestureTapCallback? tap,
  final String label,
   final InputBorder border,
  final Icon prefix,
  final FormFieldValidator<String>? validate,
) =>
    TextFormField(
      //key: key,
      keyboardType: keyboard,
      controller: controller,
      onFieldSubmitted: submit,
      onChanged: change,
      onTap: tap,
      validator: validate,

      decoration: InputDecoration(
        labelText: label,
        border: border,
        prefixIcon: prefix,
      ),
    );

//Default Button
class DefaultButton {
  final double width;
  final double height;
  final Color buttonColor;
  final Function function;
  final String text;
  final Color textColor;

  //Constructor
  DefaultButton({
    required this.width,
    required this.height,
    required this.buttonColor,
    required this.function,
    required this.text,
    required this.textColor,
  });
}

Widget defaultButton(
  final double width,
  final double height,
  final Color buttonColor,
  final Function,
  final String text,
  final Color textColor,
) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: buttonColor,
      ),
      child: MaterialButton(
        onPressed: Function,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

Widget NewReport(article, context) => InkWell(
      onTap: () {
        //navigateTo(context, WebViewScreen(article['url']));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(

              // clipBehavior: Clip.antiAliasWithSaveLayer,

              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage('${article['urlToImage']}')),
              )),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              width: 150,
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${article['title']}',

                    style: Theme.of(context).textTheme.displaySmall,

                    // overflow: TextOverflow.ellipsis,

                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${article['publishedAt']}',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget separate() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 1,
      color: Colors.black,
    ),
  );
}

void navigateTo(context, screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateAndDelPast(context, screen) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => screen), (route) {
    return false;
  });
}

/*
Widget buildArticle(news ,state)=>BlocConsumer<NewsAppCubit, NewsAppStates>(
builder: (context, state) {
return ConditionalBuilder(
condition: true, //Add yours here
builder: (context) => ListView.separated(
physics: BouncingScrollPhysics(),
itemBuilder: (context, index) => NewReport(news,context),
separatorBuilder: (context, index) => separate(),
itemCount: news.length,
),
fallback: (context) => Center(child: CircularProgressIndicator()));
},
listener: (context, state) {},
);
*/


