import { promptAction, router } from '@kit.ArkUI';
import { buffer } from '@kit.ArkTS';
import { generateRandomToken } from '../util/util';

interface GeneratedTypeLiteralInterface_1 {
  phone: string;
  password: string;
}

@Entry
@Component
struct Login {
  @State loginByPassword: boolean = true;
  private phone: string = ''
  private password: string = ''
  @State checked: boolean = false

  @Styles
  normalStyle() {
    .backgroundColor('#eee')
  }

  @Styles
  pressedStyle() {
    .backgroundColor("#33A634")
  }

  @Builder
  builderButton(text: string, callback: Function) {
    Button(text, { type: ButtonType.Normal })
      .width('100%')
      .height(50)
      .borderRadius(8)
      .stateStyles({
        normal: this.normalStyle,
        pressed: this.pressedStyle,
        focused: this.pressedStyle
      })
      .fontColor('#000')
      .onClick(() => {
        callback()
      })
  }

  onLogin() {
    if (!this.checked) {
      this.getUIContext().getPromptAction().showToast({
        message: "请先勾选协议",
        duration: 2000,
        showMode: promptAction.ToastShowMode.TOP_MOST,
        bottom: 80,
        backgroundColor: "red",
      })
      return
    }

    if (this.loginByPassword) {
      if (!this.password || !this.phone) {
        this.getUIContext().getPromptAction().showToast({
          message: "请输入手机号或者密码",
          duration: 2000,
          showMode: promptAction.ToastShowMode.TOP_MOST,
          bottom: 80,
          backgroundColor: "red",
        })
        return
      }

      let data: Uint8Array = getContext(this).resourceManager.getRawFileContentSync("user.json");
      const json = buffer.from(data.buffer).toString('utf-8');
      const uses: Array<GeneratedTypeLiteralInterface_1> = JSON.parse(json)
      const index = uses.findIndex((value) => value.phone == this.phone && value.password == this.password)
      if (index > -1) {
        const token = generateRandomToken(168)
        console.log('手机号:', this.phone)
        console.log('密码:', this.password)
        console.log('token认证:', token)
        router.replaceUrl({ url: 'pages/Index' });
      } else {
        this.getUIContext().getPromptAction().showToast({
          message: "手机号或者密码输出错误",
          duration: 2000,
          showMode: promptAction.ToastShowMode.TOP_MOST,
          bottom: 80,
          backgroundColor: "red",
        })
        return
      }
    } else {
      router.replaceUrl({ url: 'pages/Index' });
    }
  }

  build() {
    Column({ space: 16 }) {
      Image($r('app.media.app_icon')).width(120)
      if (this.loginByPassword) {
        TextInput({ placeholder: "请输入手机号" })
          .type(InputType.Number)
          .onChange((v) => {
            this.phone = v
          })
        TextInput({ placeholder: "请输入密码" })
          .type(InputType.Password)
          .onChange((v) => {
            this.password = v
          })
      } else {
        Text("189****06")
        Text('华为绑定账户号码')
      }

      Button("登录")
        .width('100%')
        .onClick(() => {
          this.onLogin()
        })

      Row().height(40)
      this.builderButton("华为账户一键登录", () => {
        this.loginByPassword = false
      })
      this.builderButton("手机号密码登录", () => {
        this.loginByPassword = true
      })

      Row() {
        Toggle({ type: ToggleType.Checkbox, isOn: false })
          .onChange((v) => this.checked = v)

        Text('已阅读并同意《用户协议》《隐私政策》和《儿童隐私政策》')
      }.margin({
        top: 90
      })
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}