import { TitleComponent } from '../components/back'
import { request } from '../http/request'
import { promptAction } from '@kit.ArkUI'
import { UserInfo } from '../model/user';

@Entry
@Component
struct Scholarship {
  @StorageProp('topHeight') topHeight: number = 0
  @StorageProp('user') user: UserInfo | undefined = undefined;
  private formData: ESObject = {}

  async submit() {
    await request.post("/scholarship/submit", this.formData)
    promptAction.showToast({
      message: '奖学金已申请',
      duration: 2000
    });
  }

  build() {
    Scroll() {
      Column({ space: 24 }) {
        TitleComponent({
          title: '奖学金申请'
        })

        Column({ space: 16 }) {
          Row() {
            Text("国家奖学金")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Text("8000 元/年")
              .fontColor("#4f46e5")
              .fontWeight(500)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row({ space: 8 }) {
            Image($r('app.media.super'))
              .width(20)
            Text("学习成绩优异")
          }

          Row({ space: 8 }) {
            Image($r('app.media.all'))
              .width(20)
            Text("社会实践、创新能力、综合素质等方面特别\n突出")
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor('rgba(79,70,229,0.05)')

        Column({ space: 16 }) {
          Row() {
            Text("学业奖学金")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Text("5000 元/年")
              .fontColor("#2563eb")
              .fontWeight(500)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row({ space: 8 }) {
            Image($r('app.media.paiming'))
              .width(20)
            Text("学习成绩排名前 10%")
          }

          Row({ space: 8 }) {
            Image($r('app.media.jige'))
              .width(20)
            Text("无不及格科目")
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor('#50dbeafe')

        Column({ space: 16 }) {
          Row() {
            Text("专项奖学金")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Text("3000 元/年")
              .fontColor("#16a34a")
              .fontWeight(500)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row({ space: 8 }) {
            Image($r('app.media.tuchu'))
              .width(20)
            Text("在某一专业领域表现突出")
          }
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor('#50dcfce7')

        Column({ space: 18 }) {
          Text("基本信息")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Column({ space: 18 }) {
            Row() {
              Text("学号：")
              Text(this.user?.studentNo)
            }

            Row() {
              Text("姓名：")
              Text(this.user?.studentName)
            }

            Row() {
              Text("院系：")
              Text(this.user?.studentDepart)
            }
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#f9fafb')
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("学习成绩")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Column({ space: 18 }) {
            Row() {
              Text("平均学习成绩：")
                .width(120)
              TextInput()
                .backgroundColor('#fff')
                .layoutWeight(1)
                .borderRadius(12)
                .onChange((e) => {
                  this.formData.studentScore = e
                })
            }

            Row() {
              Text("专业排名：")
                .width(120)
              TextInput()
                .backgroundColor('#fff')
                .layoutWeight(1)
                .borderRadius(12)
                .onChange((e) => {
                  this.formData.studentRank = e
                })
            }
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#f9fafb')
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("获奖情况")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Row() {
            TextArea({ placeholder: "请详细描述您的获奖经历" })
              .backgroundColor('#f9fafb')
              .layoutWeight(1)
              .borderRadius(12)
              .constraintSize({ minHeight: 90 })
              .onChange((e) => {
                this.formData.awardExperience = e
              })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Column({ space: 18 }) {
          Text("社会实践")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Row() {
            TextArea({ placeholder: '请详细描述您的社会实践经历' })
              .backgroundColor('#f9fafb')
              .layoutWeight(1)
              .borderRadius(12)
              .constraintSize({ minHeight: 90 })
              .onChange((e) => {
                this.formData.socialPractice = e
              })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Button("提交申请")
          .width('100%')
          .backgroundColor('#4f46e5')
          .onClick(() => {
            this.submit()
          })
      }
      .padding(16)
    }
  }
}