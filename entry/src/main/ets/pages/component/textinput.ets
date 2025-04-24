import { inputMethod } from '@kit.IMEKit';
import { emitter } from '@kit.BasicServicesKit';

@Extend(Text)
function verifyCodeUnitStyle() {
  .fontSize($r("sys.float.ohos_id_text_size_body1"))
  .fontWeight(60)
  .textAlign(TextAlign.Center)
  .width('100%')
  .height('100%')
  .margin({
    left: 10,
    right: 10
  })
  .border({
    width: { bottom: 1 },
    color: { bottom: Color.Grey },
    style: { bottom: BorderStyle.Solid }
  })
}

@Component
export struct VerifyCodeComponentWithoutCursor {
  @State codeText: string = "";
  private readonly verifyID: string = "verifyCodeComponent";
  private inputController: inputMethod.InputMethodController = inputMethod.getController();
  // 监听键盘弹出收起状态
  @State isKeyboardShow: boolean = false;
  private verifyCodeLength: number = 6;
  private isListen: boolean = false;
  private textConfig: inputMethod.TextConfig = {
    inputAttribute: {
      textInputType: inputMethod.TextInputType.TEXT,
      enterKeyType: inputMethod.EnterKeyType.GO
    },
  };
  private codeIndexArray: Array<number> = Array.from([0, 1, 2, 3, 4, 5]);
  // 注册路由返回函数，案例插件不触发
  popRouter: () => void = () => {};

  aboutToAppear(): void {
    // 注册返回监听，包括点击手机返回键返回与侧滑返回
    this.listenBackPress();
  }

  async attachAndListen(): Promise<void> {
    focusControl.requestFocus(this.verifyID);
    await this.inputController.attach(true, this.textConfig);
    this.listen();
    this.isKeyboardShow = true;
  }

  listenBackPress() {
    let innerEvent: emitter.InnerEvent = {
      eventId: 5
    };
    // 收到eventId为5的事件后执行回调函数
    emitter.on(innerEvent, () => {
      if (this.isKeyboardShow) {
        // 退出文本编辑状态
        this.inputController.hideTextInput();
        this.isKeyboardShow = false;
      } else {
        this.popRouter();
      }
    });
  }

  aboutToDisappear(): void {
    this.off();
    // 关闭事件监听
    emitter.off(5);
  }

  async attach() {
    await this.inputController.attach(true, this.textConfig);
  }

  /**
   * TODO：知识点：解绑
   */
  off(): void {
    this.inputController.off("insertText");
    this.inputController.off("deleteLeft");
    this.isListen = false;
    // 退出文本编辑状态
    this.inputController.hideTextInput();
    this.isKeyboardShow = false;
  }


  listen() {
    if (this.isListen) {
      return;
    }
    console.log('add listen')
    this.inputController.on("insertText", (text: string) => {
      if (this.codeText.length >= this.verifyCodeLength || text === ' ') {
        return;
      }
      console.log('text',text)
      this.codeText += text;
      if (this.codeText.length === this.verifyCodeLength) {
        // logger.info("VerifyCode: %{public}s", this.codeText);
        console.log(this.codeText)
      }
    })

    this.inputController.on("deleteLeft", (length: number) => {
      this.codeText = this.codeText.substring(0, this.codeText.length - 1);
    })
    this.isListen = true;
  }

  /**
   * TODO 知识点：部分验证码场景要完全禁止对输入验证码的选中、复制等功能，因此可以使用Text组件完成
   */
  @Builder
  buildVerifyCodeComponent() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
      ForEach(this.codeIndexArray, (item: number, index: number) => {
        Text(this.codeText[item])
          .verifyCodeUnitStyle()
      }, (item: number, index: number) => item.toString())
    }
    .id(this.verifyID)
    .onBlur(() => {
      this.off();
    })
    .backgroundColor(Color.Transparent)
    .height(50)
    .defaultFocus(true)
    .onClick(() => {
      this.attachAndListen();
    })
  }

  build() {
    Row() {
      this.buildVerifyCodeComponent()
    }
  }
}