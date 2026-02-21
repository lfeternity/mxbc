<template>
  <div class="ai-service-container">
    <div class="header"> 
      <h3>AI智能客服</h3> 
      <el-button icon="el-icon-close" @click="closeService">关闭</el-button>
    </div>
    
    <div class="message-container">
      <!-- 统一循环 -->
      <div 
        v-for="msg in messages"
        :key="msg.id"
        class="message"
        :class="msg.role"
      >
        <!-- Bot/Human 头像在左侧 -->
        <img 
          v-if="msg.role !== 'user'"
          :src="msg.role === 'human' ? humanAvatar : aiAvatar"
          class="avatar"
        />
        
        <!-- 消息内容 -->
        <div class="content">{{ msg.content }}</div>

        <!-- User 头像在右侧 -->
        <img 
          v-if="msg.role === 'user'"
          src="@/assets/user-avatar.png"
          class="avatar"
        />
      </div>
      
      <!-- 等待动画 -->
      <div class="message bot" v-if="loading">
        <img src="@/assets/ai-avatar.png" alt="AI客服" class="avatar" />
        <div class="content loading-animation">
          <div class="loader-dot" v-for="(_, i) in 3" :key="i"></div>
        </div>
      </div>
    </div>
    
    <div class="input-area">
      <el-input 
        v-model="inputText" 
        placeholder="请输入问题..." 
        @keyup.enter.native="sendMessage"
      ></el-input>
      <el-button 
        type="primary" 
        @click="sendMessage"
      >发送</el-button>
    </div>
  </div>
</template>


<script>
import { aigetAnswer } from '@/api/ai.ts' // 引入API请求方法
export default {
  data() {
    return {
      inputText: '',
      messages: [
        { id: 1, role: 'bot', content: '您好！我是AI客服，有什么可以帮助您的？' }
      ],
      humanMessages: [],
      aiAvatar: require('@/assets/ai-avatar.png'),
      humanAvatar: require('@/assets/ai-avatar.png'),
      loading: false,
      error: null
    }
  },
  methods: {
    async sendMessage() {
      if (!this.inputText.trim()) return
      
      // 添加用户消息
      const userMessage = {
        id: Date.now(),
        role: 'user',
        content: this.inputText
      }
      this.messages.push(userMessage)
      this.inputText = ''
      this.scrollToBottom()
      
      try {
        this.loading = true
        
      
        const response = await aigetAnswer({
          question: userMessage.content
        })
        
        // 处理API返回的数据
        if (response.data) {
          this.messages.push({
            id: Date.now(),
            role: 'bot',
            content: response.data.data
          })
        } else {
          throw new Error('API返回异常: ' + response.msg || '未知错误')
        }
        
      } catch (error) {
        console.error('获取AI回复失败:', error)
        this.error = '抱歉，暂时无法回答您的问题。'
        this.messages.push({
          id: Date.now(),
          role: 'bot',
          content: this.error
        })
      } finally {
        this.loading = false
        this.scrollToBottom()
      }
    },
    
    closeService() {
      this.$router.back()
    },
    
    transferToHuman() {
      this.humanMessages.push({
        id: Date.now(),
        role: 'human',
        content: '您好，我是人工客服，很高兴为您服务！'
      })
      this.scrollToBottom()
    },
    
    scrollToBottom() {
      this.$nextTick(() => {
        const container = this.$el.querySelector('.message-container')
        if (container) {
          container.scrollTop = container.scrollHeight
        }
      })
    }
  }
}
</script>

<style scoped>
/* 样式保持不变，仅调整消息顺序逻辑 */
.ai-service-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: #f5f7fa;
}
.ai-service-container {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: #f5f7fa;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  background-color: #fff;
  border-bottom: 1px solid #eee;
}

.message-container {
  flex: 1;
  overflow-y: auto;
  padding: 15px;
  display: flex;
  flex-direction: column;
}
.message {
  display: flex;
  align-items: flex-start;
  margin-bottom: 15px;
  max-width: 100%;
}
.bot {
  justify-content: flex-start;
  align-self: flex-start;
  margin-left: 10px; /* 可根据实际情况调整距离左侧的距离 */
}
.user,.human{
  justify-content: flex-end;
  align-self: flex-end;
}
.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin: 0 10px;
}

.content {
  max-width: 70%;
  padding: 12px 18px;
  background-color: #fff;
  border-radius: 18px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
  position: relative;
  word-break: break-word;
}

.bot .content {
  border-bottom-right-radius: 4px;
}

.user .content, .human .content {
  background-color: #409eff;
  color: #fff;
  border-bottom-left-radius: 4px;
}

/* 等待动画样式 */
.loading-animation {
  display: flex;
  align-items: center;
  padding: 0;
  background-color: transparent;
}

.loader-dot {
  width: 8px;
  height: 8px;
  background-color: #909399;
  border-radius: 50%;
  margin: 0 2px;
  animation: dot-pulse 1.5s infinite ease-in-out;
}

.loader-dot:nth-child(2) {
  animation-delay: 0.2s;
}

.loader-dot:nth-child(3) {
  animation-delay: 0.4s;
}

@keyframes dot-pulse {
  0%, 100% {
    transform: scale(0.5);
    opacity: 0.6;
  }
  50% {
    transform: scale(1);
    opacity: 1;
  }
}

.input-area {
  display: flex;
  padding: 10px 15px;
  background-color: #fff;
  border-top: 1px solid #eee;
  position: sticky;
  bottom: 0;
  z-index: 10;
  box-shadow: 0 -1px 3px rgba(0,0,0,0.05);
}

.input-area el-input {
  flex: 1;
  margin-right: 10px;
}

</style>